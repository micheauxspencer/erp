class DatePickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    value = object.send(attribute_name) if object.respond_to? attribute_name
    display_pattern = I18n.t('datepicker.dformat', :default => '%d/%m/%Y')
    input_html_options[:value] ||= I18n.localize(value, :format => display_pattern) if value.present?

    input_html_options[:type] = 'text'
    picker_pattern = I18n.t('datepicker.pformat', :default => 'DD/MM/YYYY')
    dayViewHeaderFormat = I18n.t('dayViewHeaderFormat', :default => 'MMMM YYYY')
    date_options = {
        locale: I18n.locale.to_s,
        dayViewHeaderFormat: dayViewHeaderFormat,
        format: picker_pattern
    }
    input_html_options[:data] ||= {}
    input_html_options[:data].merge!({date_options: date_options })

    template.content_tag :div, class: 'input-group date datepicker' do
      input = super(wrapper_options) # leave StringInput do the real rendering
      input += template.content_tag :span, class: 'input-group-btn' do
        template.content_tag :button, class: 'btn btn-default', type: 'button' do
          template.content_tag :span, '', class: 'fa fa-calendar'
        end
      end
      input
    end
  end

  def input_html_classes
    super.push ''   # 'form-control'
  end
end
