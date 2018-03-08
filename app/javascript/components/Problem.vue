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
  data: () => ({
    exm_arrangement: 'w-20'
  }),
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
.problem-container {
  width: 540px; max-width: 100%; padding: 20px; max-height: 100%; text-align: left;
  display: inline-flex; flex-direction: column; flex: 0 1 auto; word-break: break-all;
  img { display: inline-block; max-width: 100%; }
  blockquote { margin: 0; padding: .75rem; border: 1px solid #e9ecef; background: #fff; }
  .problem-info { font-size: 0.8em;
    & > div { margin-right: 0.25em;
      &:last-of-type { margin-right: 0; }
    }
    & > div > span { display: inline-block; border-radius: 0.75em; margin-right: 0.25em;
      &:last-of-type { margin-right: 0; }
    }
    .problem-order { padding: 0.25em 0.7em; background: #000; border: 1px solid #fff; color: #fff; font-weight: bold; }
    .problem-score { padding: 0.25em 0.7em; background: #fff; border: 1px solid lightgrey; }
    .problem-level { padding: 0.25em 0.5em; }
  }
  .problem-wrapper {
    & > div { background: #fff; border: 1px solid lightgrey; border-top: 0; padding: 16px; position: relative; zoom: 1;
      &::after { content: ''; display: block; clear: both; }
    }
    & > div:first-of-type { border-top: 3px solid black; border-radius: 5px 5px 0 0; }
    & > div:last-of-type { border-radius: 0 0 5px 5px; }
    .problem-content, .problem-exm-content, .problem-explanation {
      &:empty::after { content: '내용이 없습니다'; color: lightgrey; }
    }
    .problem-exm { padding: 10px; display: flex; flex-wrap: wrap;
      .problem-exm-wrapper { position: relative; display: flex; align-items: center; min-width: 20%; padding: 10px; border-radius: 5px; cursor: pointer; transition: background .25s, width .25s;
        .problem-exm-index { display: inline-block; margin: 2px; min-width: 20px; width: 20px; height: 20px; line-height: 20px; text-align: center; font-size: 0.75em; background: white; border: 1px solid lightgrey; border-radius: 50%; transition: background .25s, border .25s; cursor: pointer; }
        .problem-exm-content { margin-left: 5px; line-height: 24px; max-width: 100%; }
        &:hover { background: #f1f1f1;
          .problem-exm-index { background: lightgrey; border-color: transparent; }
        }
        &.active { background: rgba(40, 167, 69, .25);
          .problem-exm-index { background: #28a745; border-color: transparent; color: #fff; }
        }
      }
    }

    .problem-subject, .problem-explanation, .problem-answer {
      &::before { display: block; font-weight: bold; color: grey; text-align: left; margin-bottom: 0.25em; margin-top: -0.25em; }
    }
    .problem-answer-input { padding: 10px; }
    .problem-subject { background: #f1f1f1;
      &::before { content: '분류'; }
    }
    .problem-explanation { background: #f1f1f1;
      &::before { content: '해설'; }
    }
    .problem-answer { background: #f1f1f1; padding: 10px 16px; text-align: right;
      &::before { content: '정답'; margin-top: 0; margin-bottom: -1.5em; }
      .problem-answer-wrapper {
        &::before { content: '정답은 ' } &::after { content: ' 입니다' }
        .problem-answer-seg { display: inline-block; font-weight: bold; min-width: 10px;
          &:empty::before { content: '-' }
        }
      }
      .problem-ratio { font-size: 0.8em; color: grey;
        .under-border { border-bottom: 1px solid; }
        &::before { content: "정답률: " }
      }
      &.is-objective {
        .problem-answer-seg::after { content: '번' }
        .problem-ratio::before { content: "문항별 선택률: " }
      }
    }
  }
  .problem-sources { font-size: 0.8em; font-style: italic; }
  .problem-tags { text-align: right; }
}

.problem-preview {
  .problem-score, .problem-subject, .problem-level i, .problem-answer-wrapper, .problem-answer-input > input { cursor: pointer; }
  .problem-wrapper {
    .problem-score, .problem-subject, .problem-content, .problem-exm-wrapper, .problem-answer-input, .problem-explanation, .problem-answer {
      position: relative; cursor: pointer; outline: none; transition: background .25s;
      &:hover, &.is-editing { background-color: rgba(0, 123, 255, .1) !important; }
    }
  }
}

.editor-grid { width: 1060px; margin: 0 auto; word-break: break-all;
  img { display: inline-block; max-width: 100%; }
  blockquote { margin: 0; padding: .75rem; border: 1px solid #e9ecef; background: #fff; }
  .preview-wrapper { max-width: 500px; border: 1px solid lightgrey; border-radius: 5px;
    .preview-header { height: 43px; line-height: 43px; text-align: center; background-color: rgba(0, 0, 0, .03); border-bottom: 1px solid rgba(0, 0, 0, 0.125); }
    .preview-content { padding: 10px 16px; height: calc(100% - 80px); }
  }
}
</style>
