class ReceiptsController < ApplicationController
  # GET /receipts
  # GET /receipts.json
  def index
    @receipts = Receipt.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @receipts }
    end
  end

  def index_mine
    @receipts = current_user.receipts
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @receipts }
    end
  end

  # GET /receipts/1
  # GET /receipts/1.json
  def show
    @receipt = Receipt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @receipt }
    end
  end

  # GET /receipts/new
  # GET /receipts/new.json
  def new
    @receipt = Receipt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @receipt }
    end
  end

  # post /receipts
  def from_text
    if params[:name].present? && params[:data].present?
      puts params[:data]
      lines = params[:data].split("\n")
      items = []
      lines.each do |a|
        tokens = a.strip().split(" ")
        if tokens.length >= 5
          type = tokens[0]
          name = tokens[1..-4].join(" ")
          quantity = tokens[-3]
          price_per_item = tokens[-2]
          price_total = tokens[-1]
          if is_int?(quantity) && is_int?(price_per_item) && is_int?(price_total)
            items << { 
                :letter => type, 
                :name => name, 
                :quantity => quantity,
                :price => price_per_item,
                :total => price_total
            }
          end
        end
      end
      if items.length > 0
        e = params[:name].gsub("_at_", "@")
        attached_user = User.find_by_email(e)
        if attached_user == nil
          puts 'did not find any user: anonymous'
          r = Receipt.create(:store_id => 1, :timestamp => DateTime.now)
        elsif
          r = Receipt.create(:store_id => 1, :user_id => attached_user.id, :timestamp => DateTime.now)
        end
        r.receipt_items.create(items)
        r.save!
      end
      render :text => 'ok', :status => 200
    else
      render :text => 'you suck', :status => 403
    end
  end

  # GET /receipts/1/edit
  def edit
    @receipt = Receipt.find(params[:id])
  end

  # POST /receipts
  # POST /receipts.json
  def create
    @receipt = Receipt.new(params[:receipt])

    respond_to do |format|
      if @receipt.save
        format.html { redirect_to @receipt, notice: 'Receipt was successfully created.' }
        format.json { render json: @receipt, status: :created, location: @receipt }
      else
        format.html { render action: "new" }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /receipts/1
  # PUT /receipts/1.json
  def update
    @receipt = Receipt.find(params[:id])

    respond_to do |format|
      if @receipt.update_attributes(params[:receipt])
        format.html { redirect_to @receipt, notice: 'Receipt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroy
    @receipt = Receipt.find(params[:id])
    @receipt.destroy

    respond_to do |format|
      format.html { redirect_to receipts_url }
      format.json { head :no_content }
    end
  end

  private

  def is_int?(x)
    !!(x =~ /^[-+]?[0-9\.]+$/)
  end
end
