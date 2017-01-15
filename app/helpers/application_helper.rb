module ApplicationHelper
  def nav_link_to(current_identifier, *args, &block)
    identifier = block_given? ? args[1].delete(:identifier) : args[2].delete(:identifier)
    content_tag :li, class: (:active if identifier == current_identifier) do
      link_to(*args, &block)
    end
  end

  def navbar_link_to(*args, &block)
    nav_link_to(@current_nav_identifier, *args, &block)
  end

  def subnav_link_to(*args, &block)
    nav_link_to(@current_subnav_identifier, *args, &block)
  end

  def no_record_tr(colspan, text = 'No records to display')
    content_tag(:tr, content_tag(:td, text, colspan: colspan, class: 'text-center text-muted' ), class: 'tr-no-record')
  end

  def partial_exist?(partial_name, prefixes = lookup_context.prefixes)
    lookup_context.exists?(partial_name, prefixes, true)
  end

  def status_tag(boolean,options={})
    options[:true_text] ||= ''
    options[:false_text] ||= ''

    if boolean
      content_tag(:span, options[:true_text],class:'status true')
    else
      content_tag(:span, options[:false_text],class:'status false')
    end

  end

  def getNotificationColor(message_count)
      if message_count > 0
        return "background: #ffffe6;"
      else
        return ""
      end
  end

  def getFaColour(name)

    case name
      when "Red"
        return "btn btn-danger"
      when "Yellow"
        return "btn btn-warning"
      when "Green"
        return "btn btn-success"
      when "LightBlue"
        return "btn btn-info"
      when "Blue"
        return "btn btn-primary"
    end
  end

end

module ActionView
  module Helpers
    class FormBuilder
      def date_select(method, options = {}, html_options = {})
        existing_date = @object.send(method)

        # Set default date if object's attr is nil
        existing_date ||= Time.now.to_date

        formatted_date = existing_date.to_date.strftime("%F") if existing_date.present?
        @template.content_tag(:div, :class => "input-group") do
          text_field(method, :value => formatted_date, :class => "form-control datepicker", :"data-date-format" => "YYYY-MM-DD") +
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
        end
      end

      def datetime_select(method, options = {}, html_options = {})
        existing_time = @object.send(method)

        # Set default date if object's attr is nil
        existing_date ||= Time.now

        formatted_time = existing_time.to_time.strftime("%F %I:%M %p") if existing_time.present?
        @template.content_tag(:div, :class => "input-group") do
          text_field(method, :value => formatted_time, :class => "form-control datetimepicker", :"data-date-format" => "YYYY-MM-DD hh:mm A") +
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
        end
      end
    end
  end
end
