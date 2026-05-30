#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <deck.html>" >&2
  exit 2
fi

deck="$1"

if [[ ! -f "$deck" ]]; then
  echo "Deck not found: $deck" >&2
  exit 2
fi

perl -0ne '
  my @slides = split(/<section\b/i, $_);
  shift @slides;
  my $failed = 0;
  my $i = 0;
  my $component_re = qr/
    table|metric-strip|column-chart|ranked-bars|chart-block|heatmap|
    comparison-table|weighted-scorecard|sensitivity-grid|outcome-support|process-flow|phase-roadmap|
    numbered-list-grid|decision-log|pros-cons-table|filter-cascade|
    framework-map|risk-matrix|range-competency-chart|range-comparison-plot|
    dot-scale-comparison|pie-chart|donut-chart|stacked-bars|scatter-plot|
    quote-insight|quote-large|quote-small|dense-list|card-grid|card\b|
    quadrant-matrix|waterfall|roadmap|timeline|stage-gate|value-chain|
    funnel-steps|loop-cycle|journey-map|milestone-track|pyramid-stack|
    cause-effect|diverging-textboxes|from-to-multi|compass-choice
  /x;
  for my $slide (@slides) {
    $i++;
    next unless $slide =~ /class=["][^"]*\bslide\b/i;
    next if $slide =~ /data-allow-divider=["]true["]/i;
    next if $slide =~ /class=["][^"]*\b(cover|default-ending)\b/i;
    next if $slide =~ /data-title=["][^"]*(cover|closing|ending|thank you)["]/i;
    my $plain = $slide;
    $plain =~ s/<script\b.*?<\/script>//gis;
    $plain =~ s/<style\b.*?<\/style>//gis;
    $plain =~ s/<[^>]+>/ /g;
    $plain =~ s/\s+/ /g;
    my $has_component = $slide =~ /class=["][^"]*($component_re)[^"]*["]/i;
    my $is_sectionish = $slide =~ /data-title=["][^"]*section/i
      || $plain =~ /\bSection\s*\d+/i
      || $plain =~ /数据支撑|基本面分析|板块与行业分析|行业分析|Section\s+/i;
    if (($is_sectionish || length($plain) < 220) && !$has_component) {
      print STDERR "Quality check failed: slide $i has no evidence/component structure. Add a real component or mark an intentional divider with data-allow-divider=\"true\".\n";
      $failed = 1;
    }
  }
  exit($failed ? 1 : 0);
' "$deck"

echo "Deck quality check passed: $deck"
