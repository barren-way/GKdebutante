#!/usr/bin/ruby
# @Author: Marte
# @Date:   2021-01-04 18:13:52
# @Last Modified by:   Marte
# @Last Modified time: 2021-01-04 18:50:36
class Dashboard::BaseController < ApplicationController

  before_action :auth_user
  before_action :fetch_home_data

end
