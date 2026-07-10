return {
    diff = function(args)
        local handle = io.popen("git diff --no-ext-diff")
        if handle then
            local result = handle:read("*a")
            handle:close()

            if result == "" then
                return ""
            end

            return result
        end
    end,
}
