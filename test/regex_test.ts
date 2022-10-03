import test from 'node:test';
import assert from 'node:assert';
import fs from 'fs';

import RE2 from 're2';
import JSON5 from 'json5';

test('extractVersionTemplate', (_t) => {
  [
    {
      plugin: 'bun',
      source: 'bun-v0.1.11',
      extracted: '0.1.11',
    },
    {
      plugin: 'deno',
      source: 'v1.25.2',
      extracted: '1.25.2',
    },
    {
      plugin: 'direnv',
      source: 'v2.32.1',
      extracted: '2.32.1',
    },
    {
      plugin: 'elixir',
      source: 'v1.14.0',
      extracted: '1.14.0',
    },
    {
      plugin: 'erlang',
      source: 'OTP-24.3.4.5',
      extracted: '24.3.4.5',
    },
    {
      plugin: 'golang',
      source: 'go1.19.1',
      extracted: '1.19.1',
    },
    {
      plugin: 'haskell',
      source: 'ghc-9.4.2-release ',
      extracted: '9.4.2',
    },
    {
      plugin: 'helm',
      source: 'v3.9.4',
      extracted: '3.9.4',
    },
    {
      plugin: 'idris',
      source: 'v1.3.4',
      extracted: '1.3.4',
    },
    {
      plugin: 'julia',
      source: 'v1.8.1',
      extracted: '1.8.1',
    },
    {
      plugin: 'kotlin',
      source: 'v1.7.10',
      extracted: '1.7.10',
    },
    {
      plugin: 'kustomize',
      source: 'kustomize/v4.5.7',
      extracted: '4.5.7',
    },
    {
      plugin: 'lua',
      source: 'v5.4.4',
      extracted: '5.4.4',
    },
    {
      plugin: 'nim',
      source: 'v1.6.6',
      extracted: '1.6.6',
    },
    {
      plugin: 'nodejs',
      source: 'v18.9.0',
      extracted: '18.9.0',
    },
    {
      plugin: 'perl',
      source: 'v5.37.3',
      extracted: '5.37.3',
    },
    {
      plugin: 'php',
      source: 'php-8.1.10',
      extracted: '8.1.10',
    },
    {
      plugin: 'python',
      source: 'v3.9.14',
      extracted: '3.9.14',
    },
    {
      plugin: 'shellcheck',
      source: 'v0.8.0',
      extracted: '0.8.0',
    },
    {
      plugin: 'shfmt',
      source: 'v3.5.1',
      extracted: '3.5.1',
    },
    {
      plugin: 'terraform',
      source: 'v1.2.0',
      extracted: '1.2.0',
    },
    {
      plugin: 'trivy',
      source: 'v0.31.3',
      extracted: '0.31.3',
    },
  ].forEach(example => {
    const { plugin, source, extracted } = example;
    test(plugin, (_t) => {
      const definition = fs.readFileSync(`plugins/${plugin}.json5`, 'utf8');
      const json5 = JSON5.parse(definition);
      const pattern = new RE2(json5['regexManagers'][0]['extractVersionTemplate']);
      const matched = pattern.exec(source);
      if (matched) {
        // @ts-ignore
        assert.equal(extracted, matched.groups['version']);
      } else {
        throw 'RE2 did not match to given string';
      }
    });
  });
});

test('fileMatch', (_t) => {
  fs.readdirSync('plugins').forEach(plugin => {
    test(plugin, (_t) => {
      const definition = fs.readFileSync(`plugins/${plugin}`, 'utf8');
      const json5 = JSON5.parse(definition);
      const pattern = new RE2(json5['regexManagers'][0]['fileMatch'][0]);
      assert.equal(true, !!pattern.exec('.tool-versions'));
      assert.equal(true, !!pattern.exec('examples/.tool-versions'));
      assert.equal(false, !!pattern.exec('spec/fixtures/.tool-versions-invalid-duplicated'));
    });
  });
});
