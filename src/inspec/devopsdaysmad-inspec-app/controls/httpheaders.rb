title 'Check http headers'

site = "https://www.pasionporlosbits.com" 

control 'check_http_status' do
    describe http(site) do
        its('status') { should cmp '200'}
    end
end

control 'web_check_httpsecureheaders' do
     describe http(site) do
         its ('headers.X-XSS-Protection') { should cmp '1; mode=block'}
         its ('headers.Set-Cookie') { should match /HttpOnly/}
         its ('headers.X-Frame-Options') { should cmp 'DENY' }
         its ('headers.X-Content-Type-Option') { should cmp 'nosniff' }
         its ('headers.Set-Cookie') { should match /HttpOnly/}
         its ('headers.Content-Security-Policy') { should match /script-src 'self'/ }

     end
 end
