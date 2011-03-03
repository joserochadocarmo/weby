module CssesHelper
  def make_menu(cssrel, args={})
    menu ||= ""
    get_permissions(current_user, '', args).each do |permission|
      if controller.class.instance_methods(false).include?(permission.to_sym)
        if @site.id == cssrel.site.id
          case permission.to_s
            when "show"
              menu += link_to(t('show'), {:action => 'show', :id => cssrel.css.id}, :class => 'icon icon-show', :alt => t('show'), :title => t('show')) + " "
            when "edit"
              menu += link_to(t("edit"), {:action => "edit", :id => cssrel.css.id}, :class => 'icon icon-edit', :alt => t('edit'), :title => t('edit')) + " "
          end
        else
          case permission.to_s
            when "show"
              menu += link_to(t('show'), {:action => 'show', :id => cssrel.css.id}, :class => 'icon icon-show', :alt => t('show'), :title => t('show')) + " "
            when "copy"
              menu += link_to(t('copy'), {:action => 'copy', :id => cssrel.css.id}, :class => 'icon icon-fav', :alt => t('copy'), :title => t('copy')) + " "
          end
        end
      end
    end
    menu
  end

  def follow(obj, following)
    if following == false 
      menu = link_to(image_tag("false.png", :alt => t("disable")), {:action => "follow", :id => obj.id, :following => "#{following}"}, :title => t("activate_deactivate"))
    else
      menu = link_to(image_tag("true.png", :alt => t("enable")), {:action => "follow", :id=> obj.id, :following => "#{following}"}, :title => t("activate_deactivate"))
    end
    menu
  end
end
