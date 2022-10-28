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
  const plugins = new Set(examples.map((example) => example.plugin));

  for (const basename of fs.readdirSync('plugins')) {
    const pluginPath = path.join('plugins', basename);
    const plugin = path.parse(pluginPath).name;
    const definition = fs.readFileSync(pluginPath, 'utf8');
    const json5 = JSON5.parse(definition);
    const regexManagers = json5['regexManagers'] as RegExManager[];

    if (regexManagers.some((regexManager) => 'extractVersionTemplate' in regexManager)) {
      await t.test(`${plugin} - exists`, (_t) => {
        assert.equal(true, plugins.has(plugin));
      });
    }
  }

  for (const example of examples) {
    const { plugin, source, extracted } = example;
    await t.test(`${plugin} - pattern`, (_t) => {
      const definition = fs.readFileSync(`plugins/${plugin}.json5`, 'utf8');
      const json5 = JSON5.parse(definition);
      const regexManagers = json5['regexManagers'] as RegExManager[];

      const patterns = regexManagers.flatMap((regexManager) => {
        const patternString = regexManager['extractVersionTemplate'];
        return patternString ? new RE2(patternString) : [];
      });

      assert(patterns.length === 1);
      const pattern = patterns[0];
      assert(pattern);
      const matched = pattern.exec(source);
      assert(matched);
      // @ts-ignore - Remove this workaround after https://github.com/uhop/node-re2/pull/133 released
      assert.equal(extracted, matched.groups['version']);
    });
  }
});

test('fileMatch', async (t) => {
  for (const plugin of fs.readdirSync('plugins')) {
    await t.test(plugin, (_t) => {
      const definition = fs.readFileSync(`plugins/${plugin}`, 'utf8');
      const json5 = JSON5.parse(definition);
      const regexManagers = json5['regexManagers'] as RegExManager[];
      for (const regexManager of regexManagers) {
        assert(regexManager['fileMatch'].length === 1);
        const patternString = regexManager['fileMatch'][0];
        assert(patternString);
        const pattern = new RE2(patternString);
        assert.equal(true, !!pattern.exec('.tool-versions'));
        assert.equal(true, !!pattern.exec('examples/.tool-versions'));
        assert.equal(false, !!pattern.exec('spec/fixtures/.tool-versions-invalid-duplicated'));
      }
    });
  }
});

test('self versioning updater', async (t) => {
  const definition = fs.readFileSync('self.json', 'utf8');
  const json5 = JSON5.parse(definition);
  const regexManagers = json5['regexManagers'] as RegExManager[];
  assert.equal(1, regexManagers.length);
  const manager = regexManagers[0];
  assert(manager);

  const { fileMatch, matchStrings } = manager;

  assert.equal(true, fileMatch.length > 0);
  assert.equal(true, matchStrings.length > 0);

  await t.test('self - fileMatch', (_t) => {
    assert.equal(
      true,
      fileMatch.some((patternString) => {
        const pattern = new RE2(patternString);
        return !!pattern.exec('renovate.json');
      }),
    );

    assert.equal(
      true,
      fileMatch.some((patternString) => {
        const pattern = new RE2(patternString);
        return !!pattern.exec('renovate.json5');
      }),
    );

    assert.equal(
      false,
      fileMatch.some((patternString) => {
        const pattern = new RE2(patternString);
        return !!pattern.exec('dprint.json');
      }),
    );
  });

  await t.test('self - matchStrings', (_t) => {
    assert.equal(
      true,
      matchStrings.some((patternString) => {
        const pattern = new RE2(patternString);
        const matched = pattern.exec('"github>kachick/renovate-config-asdf#1.4.1"');
        // @ts-ignore - Remove this workaround after https://github.com/uhop/node-re2/pull/133 released
        return matched?.groups['currentValue'] === '1.4.1';
      }),
    );
  });
});

function generateComplexToolVersions(plugin: string, priorVersion: string): string {
  return `unknown_plugin1 1.0.1 0.1.0 # ${plugin} - it describes another plugin
# comment
${plugin} ${priorVersion} 0.4.2 system # comment
unknown_plugin2 2.0.1 0.2.0
unknown_plugin3 3.0.1`;
}

test('plugin extracting current version', async (t) => {
  for (const example of examples) {
    const { plugin } = example;
    if (plugin === 'scala') {
      continue;
    }
    await t.test(`${plugin} - matchStrings`, (_t) => {
      const definition = fs.readFileSync(`plugins/${plugin}.json5`, 'utf8');
      const json5 = JSON5.parse(definition);
      const regexManagers = json5['regexManagers'] as RegExManager[];

      const patterns = regexManagers.flatMap((regexManager) => {
        return regexManager['matchStrings'];
      }).flat(Infinity).map((patternString) => new RE2(patternString));

      assert(patterns.length === 1);
      const pattern = patterns[0];
      assert(pattern);
      const currentVersion = '1.4.2';
      const matched = pattern.exec(generateComplexToolVersions(plugin, currentVersion));
      assert(matched);
      // @ts-ignore - Remove this workaround after https://github.com/uhop/node-re2/pull/133 released
      assert.equal(currentVersion, matched.groups['currentValue']);
    });
  }

  await t.test(`scala - matchStrings`, (_t) => {
    const definition = fs.readFileSync(`plugins/scala.json5`, 'utf8');
    const json5 = JSON5.parse(definition);
    const regexManagers = json5['regexManagers'] as RegExManager[];

    const patterns = regexManagers.flatMap((regexManager) => {
      return regexManager['matchStrings'];
    }).flat(Infinity).map((patternString) => new RE2(patternString));

    assert(patterns.length === 2);
    const [scala2Pattern, scala3Pattern] = patterns;
    assert(scala2Pattern);
    assert(scala3Pattern);

    const scala2Matched = scala2Pattern.exec(generateComplexToolVersions('scala', '2.9.9'));
    assert(scala2Matched);
    // @ts-ignore - Remove this workaround after https://github.com/uhop/node-re2/pull/133 released
    assert.equal('2.9.9', scala2Matched.groups['currentValue']);

    const scala3Matched = scala3Pattern.exec(generateComplexToolVersions('scala', '3.9.9'));
    assert(scala3Matched);
    // @ts-ignore - Remove this workaround after https://github.com/uhop/node-re2/pull/133 released
    assert.equal('3.9.9', scala3Matched.groups['currentValue']);

    assert.equal(null, scala2Pattern.exec(generateComplexToolVersions('scala', '3.9.9')));
    assert.equal(null, scala3Pattern.exec(generateComplexToolVersions('scala', '2.9.9')));
  });
});
