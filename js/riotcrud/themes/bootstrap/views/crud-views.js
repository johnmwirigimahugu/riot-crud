riot.tag2('raw', '<span></span>', '', '', function(opts) {
    this.root.innerHTML = opts.content
});

riot.tag2('crud-action-menu', '<div class="btn-group"> <a each="{action in opts.actions}" if="{action.active}" onclick="{click}" class="btn btn-{action.buttonClass || \'default\'} btn-sm">{action.label}</a> </div>', '', '', function(opts) {
      this.mixin(viewActionsMixin);
      var self = this;
      console.info('order console.info(order mount,self.opts.actionMenu); mount',opts.actionMenu);
});

riot.tag2('crud-top-bar', '<div class="top-bar"> <div class="top-bar-title"> <span>{VM.config.title} {VM.data.id}</span> <br><small class="subheader">{VM.config.description}</small> </div> <div if="{VM.search}" id="responsive-menu"> <div class="top-bar-right"> <ul class="menu"> <li><input type="search" onkeyup="{VM.search}" class="small" style="font-size: 14px;" placeholder="Search"></li> <li><button type="button" onclick="{VM.search}" data-submit class="button small"><span class="fi-magnifying-glass"></span></button></li> </ul> </div> </div> <div class="top-bar-right"> <ul class="dropdown menu" data-dropdown-menu> <li if="{VM.selectedIds.length != 0}"> <a href="#" onclick="{VM.delete}" class="button small alert fi-trash"> Delete ({VM.selectedIds.length})</a> </li> <li if="{VM.selectedIds.length != 0}"> <a href="{VM.csvData}" onclick="{VM.delete}" download="{VM.model}.csv" class="button small secondary fi-save"> CSV ({VM.selectedIds.length})</a> </li> <li if="{VM.config.menu.list}"> <a href="#" onclick="{VM.list}" class="button small secondary fi-list-bullet"> List</a> </li> <li if="{VM.config.menu.show}"> <a href="#" onclick="{VM.show}" class="button small warning fi-page-search"> Show</a> </li> <li if="{VM.config.menu.edit}"> <a href="#" onclick="{VM.edit}" class="button small warning fi-page-edit"> Edit</a> </li> <li if="{VM.config.menu.save}"> <a href="#" onclick="{VM.save}" class="button small success fi-save"> Save</a> </li> <li if="{VM.config.menu.creation}"> <a href="#" onclick="{VM.creation}" class="button small success fi-edit"> Create</a> </li> <li if="{VM.config.menu.destroy}"> <a href="#" onclick="{VM.destroyModal}" class="button small alert fi-trash"> Delete</a> </li> <li if="{VM.search}"> <a if="{opts.delete}" class="button small secondary fi-magnifying-glass"> Search</a> </li> </ul> </div> </div>', '', '', function(opts) {
});
