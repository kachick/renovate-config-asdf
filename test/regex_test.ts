import test from 'node:test';
import assert from 'node:assert';
import fs from 'fs';
import path from 'path';

import RE2 from 're2';
import JSON5 from 'json5';

import { examples } from './examples';

// Copied from https://github.com/renovatebot/renovate/blob/0296e58e19844b6eb3583ee3197bcae42e25d9f7/lib/config/types.ts#L169-L185
// Because they does not expose these types via npm, AFAIK
interface RegexManagerTemplates {
  depNameTemplate?: string;
  packageNameTemplate?: string;
  datasourceTemplate?: string;
  versioningTemplate?: string;
  depTypeTemplate?: string;
  currentValueTemplate?: string;
  currentDigestTemplate?: string;
  extractVersionTemplate?: string;
  registryUrlTemplate?: string;
}
interface RegExManager extends RegexManagerTemplates {
  fileMatch: string[];
  matchStrings: string[];
  matchStringsStrategy?: string;
  autoReplaceStringTemplate?: string;
}

test('extractVersionTemplate', async (t) => {
  const plugins = new Set<string>(examples.map((example) => example.plugin));

  const pluginPaths = fs.readdirSync('plugins');
  for (const basename of pluginPaths) {
    const pluginPath = path.join('plugins', basename);
    const plugin = path.parse(pluginPath).name;
    await t.test(`${plugin} - exists`, (_t) => {
      const definition = fs.readFileSync(pluginPath, 'utf8');
      const json5 = JSON5.parse(definition);
      const regexManagers = json5['regexManagers'] as RegExManager[];
      if (regexManagers.some((regexManager) => 'extractVersionTemplate' in regexManager)) {
        assert.equal(true, plugins.has(plugin));
      }
    });
  }

  for (const example of examples) {
    const { plugin, source, extracted } = example;
    await t.test(`${plugin} - pattern`, (_t) => {
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
  }
});

test('fileMatch', async (t) => {
  for (const plugin of fs.readdirSync('plugins')) {
    await t.test(plugin, (_t) => {
      const definition = fs.readFileSync(`plugins/${plugin}`, 'utf8');
      const json5 = JSON5.parse(definition);
      const regexManagers = json5['regexManagers'] as RegExManager[];
      regexManagers.forEach((regexManager) => {
        const patternString = regexManager['fileMatch'][0];
        assert(patternString);
        const pattern = new RE2(patternString);
        assert.equal(true, !!pattern.exec('.tool-versions'));
        assert.equal(true, !!pattern.exec('examples/.tool-versions'));
        assert.equal(false, !!pattern.exec('spec/fixtures/.tool-versions-invalid-duplicated'));
      });
    });
  }
});
