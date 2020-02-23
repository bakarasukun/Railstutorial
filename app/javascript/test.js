var test = new Vue({
  el: '#test',
  data: {
    text: "hoge"
  },
  methods: {
    test: function (){
      this.text = 'huga'
    }
  }
})