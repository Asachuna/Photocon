module UserPhotoCommentsHelper
    def get_commented_day(comment)
        created_at = comment.created_at.in_time_zone('Tokyo')
        return created_at.strftime("%Y/%m/%d %H:%M:%S")
    end
end
