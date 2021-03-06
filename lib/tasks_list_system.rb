module TasksListSystem

  protected
  def get_tasks_list
    @tasks        = Task.where(:created_at => Time.zone.today.beginning_of_week..(Time.zone.today.end_of_week))
#   格式为
#   {用户名 => [星期一,星期二,星期三,星期四,星期五,星期六,星期日],用户二..}
    @format_tasks = {}
    @tasks.each do |task|
      @format_tasks[task.user.name]                       ||= []
      @format_tasks[task.user.name][task.created_at.wday] = task.content
    end

    Task.where(:created_at => Time.zone.today..(Time.zone.today+1)).size > 10
  end

  def auto_fill_forget(format_tasks, wday)
    User.where(:state=>'active').each do |user|
      unless format_tasks[user.name][wday]
        format_tasks[user.name][wday] = user.content
      else
        format_tasks[user.name][wday] = ''
      end
    end

  end
end