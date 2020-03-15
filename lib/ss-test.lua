--
-- test if ss is working
--
require("socket")
local https = require("ssl.https")
local body, http_code_1, headers, status = https.request("htps://www.youtube.com")
local body, http_code_2, headers, status = https.request("https://www.facebook.com") 
if http_code_1 ~= 200
then io.write('no')
elseif http_code_2 ~= 200 
then
io.write('no')
else
io.write('yes')
end

