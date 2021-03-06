Name: router-infra
Version: 0.0.1
Release: 2
Summary: OpenShift Router Infra Configuration
License: Apache-2.0
URL: https://github.com/lattebank/router-infra

Source0: configure.sh
Source1: config_tun0.sh
Source2: router-infra.service

%description
OpenShift Router Infra Configuration

%prep

%build

%install
rm -rf %{buildroot}
install -m 755 -d %{buildroot}/usr/bin/
install -m 755 -d %{buildroot}/usr/lib/systemd/system/
install -m 755 %{SOURCE0} %{buildroot}/usr/bin/
install -m 755 %{SOURCE1} %{buildroot}/usr/bin/
install -m 644 %{SOURCE2} %{buildroot}/usr/lib/systemd/system/

%files
/usr/bin/configure.sh
/usr/bin/config_tun0.sh
/usr/lib/systemd/system/router-infra.service

%changelog
