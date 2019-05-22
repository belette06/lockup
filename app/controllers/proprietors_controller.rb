# frozen_string_literal: true

class ProprietorsController < ApplicationController
  before_action :set_proprietor, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @proprietors = Proprietor.all
  end

  def new
    # @proprietor = Proprietor.new
    @proprietor = current_user.proprietor.build_user
  end

  def show
    # @proprietor = current_user.proprietor.build_user
  end

  def create
    @proprietor = Proprietor.new(params_proprietor)
    # @proprietor.user.id = current_user.id
    # @proprietor = current_user.build_proprietor(params_proprietor)
    @proprietor.user = current_user
    if @proprietor.save
      redirect_to root_path, notice: 'Proprietor was successfully create.'
    else
      render :edit
    end
  end

  def edit; end

  def update
    if @proprietor.update(params_proprietor)
      redirect_to @proprietor, notice: 'Proprietor was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    set_proprietor
    if @proprietor.delete
      redirect_to @proprietor, notice: 'Proprietor was successfully destroy.'
    else
      render :edit
    end
  end

  private

  def params_proprietor
    params.require(:proprietor).permit(:name, :user)
  end

  def set_proprietor
    @user = current_user
    @proprietor = @user.proprietor
  end
end
