module ApplicationHelper
  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      message = message.join('<br>').html_safe if message.kind_of?(Array)
      message = message.map{|k,v| "<b>#{k}</b>: #{v[0]}"}.join('<br>').html_safe if message.is_a?(Hash)
      message = message.gsub("'", %q(\\\'))
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end

    flash_messages.join("\n").html_safe
  end
end
