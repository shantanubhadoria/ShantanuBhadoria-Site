/*! jQuery Github Widget - v1.1 *
* https://github.com/JoePettersson/jquery-github-widget *
* Copyright (c) 2012 Joe Pettersson *
* Licensed under the MIT License */
(function(a,b,c,d){function g(b,c){this.element=b,this.options=a.extend({},f,c),this.init(),this.errorType=""}"use strict";var e="github",f={user:"joepettersson",show_extended_info:!0,show_follows:!0,show_repos:10,oldest_first:!1};g.prototype={init:function(){var b=this.element,c=this.options,d=this.model("user",c.user,function(d){a(b).append(g.prototype.view_layout(d.data,c))}),e=this.model("repos",c.user,function(d){a(b).find("#ghw-repos ul").append(g.prototype.view_partial_repos(d,c,b)),a(b).find("#ghw-repos #ghw-github-loader").slideUp(250,function(){a(b).find("#ghw-repos ul").slideDown(250)}),g.prototype.bind(c)})},model:function(b,c,d){var e="https://api.github.com/users/"+c.toLowerCase();b==="repos"&&(e+="/repos"),e+="?callback=?",a.getJSON(e,function(a){typeof d!="undefined"&&typeof d=="function"&&d(a)})},view_layout:function(a,b){var c="";return c+='<div id="ghw-github" style="width: '+b.width+'">',c+='<div id="ghw-header" class="ghw-clear">',c+='<div id="ghw-logo"><a href="https://github.com/">Github</a></div>',c+='<div id="ghw-user"><a href="'+a.html_url+'" id="ghw-github-user">',typeof a.avatar_url!="undefined"&&a.avatar_url.length>0?c+='<img src="'+a.avatar_url+'" alt="Avatar" width="34px" height="34px" />':c+='<img src="https://a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-140.png" alt="Avatar" width="34px" height="34px" />',c+="</a></div>",b.show_extended_info===!0&&(c+='<div id="ghw-extended-user-info">',typeof a.name!="undefined"&&a.name.length>0&&(c+='<p class="ghw-name">'+a.name+"</p>"),c+='<p class="ghw-place">',typeof a.company!="undefined"&&a.company.length>0&&(c+=a.company+" "),typeof a.location!="undefined"&&a.location.length>0&&(c+=a.location),c+="</p>",typeof a.bio=="string"&&a.bio.length>0&&(c+='<p class="ghw-bio">'+a.bio+"</p>"),a.hireable===!0&&(c+='<p class="ghw-hireable">I\'m availabe for hire!</p>'),c+='<span class="ghw-repos">'+a.public_repos+" repos</span>",c+='<span class="ghw-gists">'+a.public_gists+" gists</span>",c+="</div>"),c+='<div id="ghw-github-user-data">',c+='<h2><a href="'+a.html_url+'">',typeof a.login!="undefined"?c+=a.login:c+="User not found",c+="</a></h2>",c+='<a href="'+a.html_url+'" id="ghw-header-total-repos">'+a.public_repos+" repos</a>",b.show_follows===!0&&typeof a.login!="undefined"&&(c+=' | <a href="https://github.com/'+a.login.toLowerCase()+'/followers" id="ghw-current-followers">'+a.followers+" followers</a>"),c+="</div>",c+="</div>",c+='<div id="ghw-repos"><div id="ghw-github-loader"></div><ul></ul></div>',c+="</div>",c},view_partial_repos:function(b,c,d){var e="";return c.oldest_first===!0?b=b.data.reverse():b=b.data,a.each(b,function(a){a<=c.show_repos-1&&(e+='<li id="ghw-repo-'+a+'" class="ghw-clear ghw-repo',this.language!==null&&(e+=" double"),e+='">',e+='<div class="ghw-left">',e+='<p class="ghw-title"><a href="'+this.html_url+'" data-description="<p>'+this.name+"</p>"+this.description+'" class="ghw-github-tooltip">'+this.name+"</a></p>",e+='<p class="ghw-meta-data">',this.language!==null&&(e+='<span class="ghw-language">'+this.language+"</span></p>"),e+="</div>",e+='<div class="ghw-right">',e+='<span class="ghw-forks ghw-github-tooltip" data-description="This repo has '+this.forks+' fork(s)">'+this.forks+"</span>",e+='<span class="ghw-watchers ghw-github-tooltip" data-description="This repo has '+this.watchers+' watcher(s)">'+this.watchers+"</span>",e+='<span class="ghw-issues ghw-github-tooltip" data-description="This project has '+this.open_issues+' open issues">'+this.open_issues+"</span>",e+="</div>",e+="</li>")}),e},bind:function(b){b.show_extended_info===!0&&a("#ghw-github-user").hover(function(){a("#ghw-github #ghw-header #ghw-extended-user-info").fadeIn(250,function(){a("#ghw-github #ghw-header img").addClass("ghw-ghw-no-bottom-border")})},function(){a("#ghw-github #ghw-header #ghw-extended-user-info").fadeOut(250,function(){a("#ghw-github #ghw-header img").removeClass("ghw-ghw-no-bottom-border")})}),a("#ghw-github li").hover(function(){a(this).find(".ghw-right").animate({opacity:1},200)},function(){a(this).find(".ghw-right").animate({opacity:.3},200)}),a(".ghw-github-tooltip").hover(function(){var b='<div class="ghw-github-tooltip-content">'+a(this).attr("data-description")+"</div>";a(this).append(b)},function(){a(".ghw-github-tooltip-content").remove()})}},a.fn[e]=function(b){return this.each(function(){a.data(this,"plugin_"+e)||a.data(this,"plugin_"+e,new g(this,b))})}})(jQuery,window,document);