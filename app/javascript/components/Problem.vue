<template>
  <div class="problem-container" ref="problemPreview">
    <div class="problem-info d-flex justify-content-between align-items-center mb-1">
      <div class="d-inline-flex">
        <span class="problem-order text-nowrap" v-text='order ? order + "번" : (problem.id ? "ID " + problem.id  : "NEW")'></span>
      </div>
      <div class="d-inline-flex">
        <span class="problem-score text-nowrap" v-text='problem.score + "점"'></span>
        <span class="problem-level bg-light text-warning d-inline-flex align-items-center">
          <i class="fa" :class='[ problem.level >= 1 ? "fa-star" : "fa-star-o" ]'></i>
          <i class="fa" :class='[ problem.level >= 2 ? "fa-star" : "fa-star-o" ]'></i>
          <i class="fa" :class='[ problem.level >= 3 ? "fa-star" : "fa-star-o" ]'></i>
        </span>
      </div>
    </div>
    <div class="problem-wrapper">
      <div class="problem-content" v-html="problem.content"></div>
      <div class="problem-exm" v-if="problem.is_objective">
        <div class="problem-exm-wrapper"
             v-for="(exm, index) in [problem.exm_1, problem.exm_2, problem.exm_3, problem.exm_4, problem.exm_5]"
             :key="index"
             :class='[ { "active": problem.answer == index + 1 }, exm_arrangement ]'>
          <span class="problem-exm-index" :class='{ "active": problem.answer == index + 1 }'>{{ index + 1 }}</span>
          <span class="problem-exm-content" v-html="exm" ref="problemExmContent"></span>
        </div>
      </div>
      <div class="problem-answer-input" v-else="!problem.is_objective">
        <input class="form-control" type="text" readonly="true" :value="problem.answer">
      </div>
      <div class="problem-subject">
        <div v-if="problem.problem_subjects.length == 0">
          <span class="text-danger">분류정보 없음</span>
        </div>
        <div v-else="" v-for="problem_subject in problem.problem_subjects" :key="problem_subject.subject_id">
          <span v-text='problem_subject.subject.path'></span>
        </div>
      </div>
      <div class="problem-explanation" v-html="problem.explanation"></div>
      <div class="problem-answer" :class='[{ "is-objective": problem.is_objective }]'>
        <i class="fa fa-caret-right mr-1"></i>
        <span class="problem-answer-wrapper">
          <span class="problem-answer-seg align-bottom" v-text="problem.answer"></span>
        </span>
        <div class="problem-ratio" v-if="problem.is_objective && problem.exm_1_ratio && problem.exm_2_ratio && problem.exm_3_ratio && problem.exm_4_ratio && problem.exm_5_ratio">
          <span v-html='"① " + problem.exm_1_ratio + "<small>%</small>"' :class='{ "font-weight-bold text-dark under-border": problem.answer == 1 }'></span>
          <span v-html='"② " + problem.exm_2_ratio + "<small>%</small>"' :class='{ "font-weight-bold text-dark under-border": problem.answer == 2 }'></span>
          <span v-html='"③ " + problem.exm_3_ratio + "<small>%</small>"' :class='{ "font-weight-bold text-dark under-border": problem.answer == 3 }'></span>
          <span v-html='"④ " + problem.exm_4_ratio + "<small>%</small>"' :class='{ "font-weight-bold text-dark under-border": problem.answer == 4 }'></span>
          <span v-html='"⑤ " + problem.exm_5_ratio + "<small>%</small>"' :class='{ "font-weight-bold text-dark under-border": problem.answer == 5 }'></span>
        </div>
        <div class="problem-ratio" v-if="!problem.is_objective && problem.correct_ratio">
          <span v-html='problem.correct_ratio + "<small>%</small>"'></span>
        </div>
      </div>
    </div>
    <div class="problem-sources d-flex justify-content-start align-items-start text-muted mt-1 pl-3 pr-3" v-if="problem.problem_source_orders">
      <div class="mr-2 text-nowrap">
        <i class="fa fa-caret-right mr-1"></i><b>출제이력</b>
      </div>
      <div class="w-100">
        <div v-if="problem.problem_source_orders.length == 0">
          <span>없음</span>
        </div>
        <div v-else="" v-for="problem_source_order in problem.problem_source_orders" :key="problem_source_order.problem_source_id">
          <span v-text='problem_source_order.problem_source.name + " / " + problem_source_order.order + "번"'></span>
        </div>
      </div>
    </div>
    <div class="problem-tags" v-if="problem.problem_tags">
      <a class="badge badge-secondary mt-1 mr-1"
         v-for="tag in problem.problem_tags"
         :key="tag.id"
         href="#">{{ tag.name }}</a>
    </div>
  </div>
</template>
<script>
export default {
  name: "Problem",
  props: ['problem', 'order'],
  data () {
    return {
      exm_arrangement: 'w-20'
    }
  },
  methods: {
    exmRearrange () {
      var w = 'w-100';
      if (_.every(_.map(this.$refs.problemExmContent, function(span) { return span.clientWidth <= 190; }))) w = 'w-50';
      if (_.every(_.map(this.$refs.problemExmContent, function(span) { return span.clientWidth <= 100; }))) w = 'w-33';
      if (_.every(_.map(this.$refs.problemExmContent, function(span) { return span.clientWidth <= 45; }))) w = 'w-20';
      return this.exm_arrangement = w;
    },
    renderMath () {
      var self = this;
      var div = this.$refs.problemPreview;
      renderMathInElement(div, {
        delimiters: [ { left: "$",  right: "$",  display: false } ],
        errorCallback: function(msg) {
          $(div).highlight('$' + msg.split('`')[1] + '$', { element: 'mark', className: 'bg-danger text-light' });
        }
      });
      this.exmRearrange();
    }
  },
  mounted () {
    this.renderMath();
  }
}
</script>
<style lang="scss" scoped>
</style>
