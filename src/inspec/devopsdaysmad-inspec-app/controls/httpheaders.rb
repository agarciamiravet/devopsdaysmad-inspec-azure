title 'Check http headers'

site = "https://www.pasionporlosbits.com" 

control 'check_http_status' do
    describe http(site) do
        its('status') { should cmp '200'}
    end
end

control 'web_check_httpstatus' do
     describe http(site) do
         its ('headers.server') { should cmp 'cloudflare'}
         its ('headers.Strict-Transport-Security') { should cmp 'max-age=31536000; includeSubDomains; preload'}
         its ('headers.X-Content-Type-Options') { should cmp 'nosniff'}
         its ('headers.Set-Cookie') { should match /HttpOnly/}
         its ('Protocol') { should cmp 890 }
     end
 end
