#!/bin/sh
input_certs=(UAT_cacerts.jks DEV_cacerts.jks)
input_cert_pass=(changeit changeit)
common_cert="uat_dev_cacerts.JKS"
common_cert_pass="changeit"
for ((i=0;i<${#input_certs[@]};++i)); do
    aliases=$(keytool -list -v -keystore ${input_certs[i]} -storepass ${input_cert_pass[i]} | grep "Alias name:" | sed 's/Alias name://g')
    aliases=($aliases)
    for als in "${aliases[@]}"; do
        keytool -importkeystore -srckeystore ${input_certs[i]} -destkeystore ${common_cert} -srcalias ${als} -destalias ${als} -srcstorepass ${input_cert_pass[i]} -deststorepass ${common_cert_pass}
    done
done
