ActiveAdmin.register Payment do
  permit_params :user_id, :order_id, :bank_account_id, :name, :paid_amount, :paid_at, :created_at, :updated_at, :image, :remove_image, :phone

  menu parent: 'Payment'

  filter :user
  filter :name
  filter :paid_at
  filter :created_at

  index do
    selectable_column
    # id_column
    column :order
    column :image do |payment|
      if payment.image
        image_tag(payment.image.url(:thumb),style:'width:80px;')
      end
    end
    column :name
    column :phone
    column :paid_at
    column :paid_amount
    column :created_at
    column "ยืนยัน" do |payment|
      if payment.order && payment.status == "unpaid"
        button type:'button',id:'',class:'btn btn-success payment_paid',value:payment.order.id  do
          span do
            'ยืนยันการชำระ'
          end
        end
      elsif payment.status == "paid"
        span do
          'ชำระแล้ว'
        end
      end
    end
    actions
  end

  form do |f|
    f.inputs "Payment Details" do
      f.input :user
      f.input :order
      f.input :bank_account
      f.input :image, :image_preview => true
      f.input :remove_image, as: :boolean, required: false, label: "Remove Image"
      f.input :name
      f.input :paid_at
      f.input :paid_amount
      f.input :created_at
    end
    f.actions
  end
end
