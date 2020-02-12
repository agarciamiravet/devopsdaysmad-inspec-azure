title 'Check certificate of pasionporlosbits.com'

site = "www.pasionporlosbits.com"
ca = "Let's Encrypt Authority X3"


control "certificate-check-validity" do
    describe x509_certificate('./files/cert.pem') do
        its('issuer.CN') { should eq ca }
        its('signature_algorithm') { should cmp 'sha256WithRSAEncryption' }
        its('subject.CN') { should eq site }
        its('validity_in_days') { should be > 30}
    end
end