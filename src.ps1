#this program is a test-watcher of pages on TTmeiju.com

$tgt_addr  = "http://www.ttmeiju.com/seed/38161.html"

function get_episode_date ($addr)
    {
        $html = wget $addr
        $seedtable = $html.allelements | where class -eq "seedtable"

        $pattern = "最后更新：(?<Date>[0-9\-]+)" #NOTE THIS!!!
        if ($seedtable.innertext -match $pattern) {
            $res = $Matches.Date #NOTE THIS!!!
            }
        return $res

    }

#function get_today
#    {
#        return get-date -format yyyy-MM-dd
#    }

function invoke_notice ($date)
{
    $obj = New-Object -ComObject "WScript.Shell"
    $obj.popup("New Episode Found on $date!")
}

while ($true) {
    $temp_res = get_episode_date($tgt_addr)
    $today = get-date -Format yyyy-MM-dd
    
    if ($temp_res -eq $today){
        invoke_notice($temp_res)
        break
    } else {
        "Attempts made on {0}, no results. Now sleep for next attempt." -f (get-date -format yyyy-MM-ddThh:mm:ss)
        Start-Sleep -Seconds 3600
        #"Sleep complete"
        #break
    }
}
