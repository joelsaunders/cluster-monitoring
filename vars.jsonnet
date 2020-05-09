{
  _config+:: {
    namespace: 'monitoring',
  },
  // Enable or disable additional modules
  modules: [
    {
      // After deployment, run the create_gmail_auth.sh script from scripts dir.
      name: 'smtpRelay',
      enabled: false,
      file: import 'smtp_relay.jsonnet',
    },
    {
      name: 'armExporter',
      enabled: false,
      file: import 'arm_exporter.jsonnet',
    },
    {
      name: 'upsExporter',
      enabled: false,
      file: import 'ups_exporter.jsonnet',
    },
    {
      name: 'metallbExporter',
      enabled: false,
      file: import 'metallb.jsonnet',
    },
    {
      name: 'traefikExporter',
      enabled: true,
      file: import 'traefik.jsonnet',
    },
    {
      name: 'elasticExporter',
      enabled: false,
      file: import 'elasticsearch_exporter.jsonnet',
    },
  ],

  k3s: {
    enabled: true,
    master_ip: ['51.158.100.201'],
  },

  // Domain suffix for the ingresses
  suffixDomain: 'cluster.thebookofjoel.com',
  // If TLSingress is true, a self-signed HTTPS ingress with redirect will be created
  TLSingress: true,
  // If UseProvidedCerts is true, provided files will be used on created HTTPS ingresses.
  // Use a wildcard certificate for the domain like ex. "*.192.168.99.100.nip.io"
  UseProvidedCerts: false,
  TLSCertificate: importstr 'server.crt',
  TLSKey: importstr 'server.key',

  // Setting these to false, defaults to emptyDirs
  enablePersistence: {
    prometheus: true,
    grafana: true,
  },

  // Grafana "from" email
  grafana: {
    from_address: 'myemail@gmail.com',
  },
}
