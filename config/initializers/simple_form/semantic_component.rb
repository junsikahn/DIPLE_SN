module SimpleForm
  module Components
    module Semantic
      def icon(wrapper_options = nil)
        return unless options[:icon].present?
        content_tag(:i, '', class: "#{options[:icon]} icon")
      end

      def left_element(wrapper_options = nil)
        return unless options[:left_element].present?
        content_tag(options[:left_element][:tag],
                    options[:left_element][:text].html_safe,
                    class: options[:left_element][:class])
      end

      def right_element(wrapper_options = nil)
        return unless options[:right_element].present?
        content_tag(options[:right_element][:tag],
                    options[:right_element][:text].html_safe,
                    class: options[:right_element][:class])
      end

      def tooltip(wrapper_options = nil)
        content =
          if options[:hint].is_a?(String)
            html_escape(options[:hint])
          else
            translate_from_namespace(:hints)
          end

        return if content.nil?
        content_tag(:span, '<i class="info circle icon"></i>'.html_safe, class: 'tooltip', data: { tooltip: content.html_safe, inverted: true })
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Semantic)
