type Example = {
  plugin: string;
  source: string;
  extracted: string;
};

export const examples: Readonly<Readonly<Example>[]> = [
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
    // Currently skipping Java 17 and 18 tests because this test does not care multiple definitions for one plugin for now
    plugin: 'java',
    source: 'jdk-16.0.2+7',
    extracted: '16.0.2+7',
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
    // Currently skipping scala3 tests because this test does not care multiple definitions for one plugin for now
    // https://github.com/scala/scala/tags
    plugin: 'scala',
    source: 'v2.12.17',
    extracted: '2.12.17',
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
];
