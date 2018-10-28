ActiveAdmin.register Stuff do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  menu parent: 'Stuff',  priority: 0

  filter :stuff_type
  filter :stuff_colors
  filter :name
  filter :active


  permit_params :name, :desc, :price, :active ,:stuff_type_id ,:stuff_img ,:stuff_product_img ,:stuff_product_img_two,:belong_to_type,:additional_price,:color_ratio_0,:color_ratio_1,:color_ratio_2,:delete_stuff_button,:priority,
                :stuff_product_img_three,:remove_stuff_img,:remove_stuff_product_img,:remove_stuff_product_img_two,:remove_stuff_product_img_three,
  stuff_colors_attributes: [:id, :name, :color_code, :active, :priority ,:stuff_type_id ,:color_layer,:stuff_id,:color_price, :_destroy]

  scope "ALL",  :default => true do |stuff|
    Stuff.all()
  end
  StuffType.all().each do |st|
    scope "#{st.name}",  :default => true do |stuff|
      Stuff.where({stuff_type:StuffType.where({name:"#{st.name}"}).first})
    end
  end

  controller do

    def belongToTypeCollection

      if @stuff.belong_to_type == "โปโล" || @stuff.belong_to_type == "80"
        @stuff.belong_to_type = "80"
      elsif @stuff.belong_to_type == "เสื้อยืด" || @stuff.belong_to_type == "81"
        @stuff.belong_to_type = "81"
      elsif @stuff.belong_to_type == "ทุกประเภท" || @stuff.belong_to_type == ""
        @stuff.belong_to_type = ""
      end
      @stuff.save

    end

    def create
      super()
      belongToTypeCollection
    end

    def update
      super()
      belongToTypeCollection
    end

  end

  index do
    selectable_column
    # column :id
    column :stuff_img do |stuff_img|
      if stuff_img.stuff_img
        image_tag(stuff_img.stuff_img.url(:thumb),style:'background-color: #d9d9d9')
      end
    end
    column :stuff_product_img do |stuff_product_img|
      if stuff_product_img.stuff_product_img
        image_tag(stuff_product_img.stuff_product_img.url(:thumb),style:'background-color: #d9d9d9')
      end
    end
    column :stuff_product_img_two do |stuff_product_img|
      if stuff_product_img.stuff_product_img_two
        image_tag(stuff_product_img.stuff_product_img_two.url(:thumb),style:'background-color: #d9d9d9')
      end
    end
    column :stuff_product_img_three do |stuff_product_img|
      if stuff_product_img.stuff_product_img_two
        image_tag(stuff_product_img.stuff_product_img_three.url(:thumb),style:'background-color: #d9d9d9')
      end
    end
    column :stuff_type
    column "ประเภท" do |stuff|
      if stuff.belong_to_type == "80"
        "โปโล"
      elsif stuff.belong_to_type == "81"
        "เสื้อยืด"
      elsif stuff.belong_to_type == ""
        "ทุกประเภท"
      end
    end
    # column "ชื่อในระบบ" do |stuff|
    #   stuff.name
    # end
    column "ชื่อที่แสดง" do |stuff|
      stuff.desc
    end
    # column :belong_to_type
    # column "ราคาน้ำหนักผ้า (consumption)" do |stuff|
    #   stuff.price
    # end
    # column "ราคาเพิ่มเติม (ค่าคงที่)" do |stuff|
    #   stuff.additional_price
    # end

    # column :priority
    # column :desc
    column :active
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do

      f.input :name, :label => "ชื่อในระบบ"

      if params[:id].nil?
        f.input :belong_to_type, as: :select, collection:["โปโล","เสื้อยืด","ทุกประเภท"], :label => "ประเภท", :selected => "ทุกประเภท"
      else
        stuff = Stuff.find(params[:id])
        if "#{stuff.belong_to_type}" == "80"
          f.input :belong_to_type, as: :select, collection:["โปโล","เสื้อยืด","ทุกประเภท"], :label => "ประเภท", :selected => "โปโล"
        elsif "#{stuff.belong_to_type}" == "81"
          f.input :belong_to_type, as: :select, collection:["โปโล","เสื้อยืด","ทุกประเภท"], :label => "ประเภท", :selected => "เสื้อยืด"
        elsif "#{stuff.belong_to_type}" == ""
          f.input :belong_to_type, as: :select, collection:["โปโล","เสื้อยืด","ทุกประเภท"], :label => "ประเภท", :selected => "ทุกประเภท"
        end
      end



      f.input :desc, :label => "ชื่อที่แสดง"
      f.input :price, :label => "ราคาน้ำหนักผ้า (consumption)"
      f.input :additional_price, :label => "ราคาเพิ่มเติม (ค่าคงที่)"
      f.input :color_ratio_0
      f.input :color_ratio_1
      f.input :color_ratio_2
      # f.input :delete_stuff_button
      f.input :active
      f.input :stuff_type


      f.input :stuff_img, :image_preview => true
      f.input :remove_stuff_img, as: :boolean, required: false, label: "Remove Image"

      f.input :stuff_product_img, :image_preview => true
      f.input :remove_stuff_product_img, as: :boolean, required: false, label: "Remove Image"

      f.input :stuff_product_img_two, :image_preview => true
      f.input :remove_stuff_product_img_two, as: :boolean, required: false, label: "Remove Image"

      f.input :stuff_product_img_three, :image_preview => true
      f.input :remove_stuff_product_img_three, as: :boolean, required: false, label: "Remove Image"

      f.input :priority
      # f.inputs "stuff_product_img_two" do
      #   f.input :stuff_product_img_two
      #   f.input :remove_stuff_product_img_two, as: :boolean, required: false, label: "remove"
      # end

    end

    # f.has_many :stuff_colors do |color|
    #   # color.inputs "Colors" do
    #     # color.input :stuff_type
    #     # color.input :stuff
    #     color.input :name
    #     color.input :color_layer
    #     color.input :color_code
    #     color.input :color_price, :label => "ราคาสีผ้า"
    #     color.input :priority
    #     color.input :active
    #   # end
    # end

    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end


end
