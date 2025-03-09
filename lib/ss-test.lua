--
-- test if ss is working
--
local socket = require("socket")
local https = require("ssl.https")
local ltn12 = require("ltn12")

-- 设置超时时间（秒）
local TIMEOUT = 3

-- 测试网站列表
local test_sites = {
    "https://www.youtube.com",
    "https://www.google.com",
    "https://www.facebook.com"
}

-- 测试单个网站连接
local function test_site(url)
    local start_time = socket.gettime()
    local success = false
    
    local body, code, headers, status = https.request({
        url = url,
        timeout = TIMEOUT,
        verify = "none"
    })
    
    local end_time = socket.gettime()
    
    if code == 200 then
        success = true
    end
    
    return success, code, (end_time - start_time)
end

-- 主测试函数
local function run_ss_test()
    local all_success = true
    local results = {}
    
    for _, site in ipairs(test_sites) do
        local success, code, time = test_site(site)
        table.insert(results, {
            site = site,
            success = success,
            code = code,
            time = time
        })
        
        if not success then
            all_success = false
        end
    end
    
    -- 输出结果
    if all_success then
        io.write("yes")
    else
        io.write("no")
    end
    
    -- 可选：输出详细结果
    --[[
    for _, result in ipairs(results) do
        print(string.format("Site: %s, Success: %s, Code: %d, Time: %.2fs",
            result.site,
            result.success and "yes" or "no",
            result.code,
            result.time
        ))
    end
    --]]
end

-- 执行测试
run_ss_test()
