title 'Check http headers'

site = "https://www.pasionporlosbits.com" 

control 'check_http_status' do
    describe http(site) do
        its('status') { should cmp '301'}
    end
end

control 'web_check_httpstatus' do
     describe http(site) do
         its ('headers.X-XSS-Protection') { should cmp '1; mode=block'}
         its ('headers.Set-Cookie') { should match /HttpOnly/}
         its ('headers.X-Frame-Options') { should cmp 'ALL' }

     end
 end
