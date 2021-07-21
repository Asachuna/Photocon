module ContestsHelper
    #コンテストの終了日を計算しyyyy/mm/ddの形で返す
    def get_end_day(contest)
        duration = contest.closing_day
        created_day = contest.created_at.in_time_zone('Tokyo')
        
        end_day = created_day.days_since(duration)
        return end_day.strftime("%Y/%-m/%-d")
    end
    
    #コンテストが進行中ならTrue、終了後ならFalse
    #終了日の24時00分以降ならコンテストが終了扱いとなる
    def contest_in_progress?(contest)
        end_day = contest.created_at.days_since(contest.closing_day)
        
        #ここ最適化の余地あり
        time_end = Time.new(end_day.year, end_day.month, end_day.day,24,00,00, "+09:00")
        time_now = Time.now.in_time_zone('Tokyo')
        
        return time_now.before?(time_end)
    end
end
