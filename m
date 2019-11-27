Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3DE10AA54
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 Nov 2019 06:42:10 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A976210113331;
	Tue, 26 Nov 2019 21:45:31 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 02CD1100DC2D2
	for <linux-nvdimm@lists.01.org>; Tue, 26 Nov 2019 21:45:28 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id b10so10219494pgd.4
        for <linux-nvdimm@lists.01.org>; Tue, 26 Nov 2019 21:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=EkOpRruz24nJ/33FknH7zHxOmihjZc/sDiTdStJsMko=;
        b=L8BqT2B+aFdzilZSRP+JaDZbYGV//pLc58t4BGfaFWV02Rowz1BaQKePHeIQ3UmPup
         KuFsuMSd47XeLJLgDlUW1RjQUa5DsmBCCpfD+YIIPFoZ3FuBT/GEVAU+Zpvbz//RIc4R
         5Hn4Jydq9vhRJlug0k9nCh2CZ57yxa9yUAjP2LSARAjvRGOAquj4YJvNAsKtINCvQ58i
         iJ7tgHNM7C1LMKuDdq8jBj2sUc7vcQewBvRgGV3pmUjRbwOszLFN5P60Cx6dzJFFYy9N
         KcjNW7fKSfsWGlLhZ1Y5YS8O9jESn4P4os2iwRiUKXVKWky0FrxWnH4NfOT9yu4EK/95
         jeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EkOpRruz24nJ/33FknH7zHxOmihjZc/sDiTdStJsMko=;
        b=TdxzxV4wysGLhUvyHfUlgGeEuj++v3hxjxjy/ebcQYNIeNXkfwUhuX9GYwHuEdZrQ5
         WviNmctL5+r5WtT0ApW7scxEtR05ifSSPeW0pbKcCtkXC28l2dM8jg/WMF29yKMHQx3T
         DEJNpo4dQ2syEZqZK1w/o/mMf2fA/Sw3sh7oqbZO3IBDvqelh2s+eoMWUoMrVHDi7nsR
         fuxIipNshqDN5hshVmUF6nIlkIe18VmDq8PvAgWokZK4Wk8fgvReHootrPUF/0brKN3Z
         SxRWt0iSqoC3oHvFI02JzwloS8vkKqy+ih0wIERv/V7lFKrAT+r1yY3QIJCJ9Xvx7ph6
         WZQw==
X-Gm-Message-State: APjAAAUAn62WFCghbBjjXnUMUMGFaZCcmwyM7WgdNACjGKb7bePlurkY
	M/gN7G3JWipGH/WlXsbuysw3tNtQDJM=
X-Google-Smtp-Source: APXvYqzcffP1F/oQNmdEqNHliXuewUGTwkgFOx6GYYcVBNkicNpstCsVPPqlFdvV33tiTSqm+2JIoQ==
X-Received: by 2002:aa7:8216:: with SMTP id k22mr25858693pfi.149.1574833325065;
        Tue, 26 Nov 2019 21:42:05 -0800 (PST)
Received: from localhost ([49.207.59.2])
        by smtp.gmail.com with ESMTPSA id q6sm2708212pfh.127.2019.11.26.21.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:42:02 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, harish@linux.ibm.com
Subject: Re: [PATCH 1/2] rename nfit_test_bus with a more generic name
In-Reply-To: <20190923033015.26732-1-santosh@fossix.org>
References: <20190923033015.26732-1-santosh@fossix.org>
Date: Wed, 27 Nov 2019 11:12:00 +0530
Message-ID: <87zhghan9z.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: 3HGJQX4YLVRK5TAHGNQ744LAAWVQHTFB
X-Message-ID-Hash: 3HGJQX4YLVRK5TAHGNQ744LAAWVQHTFB
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3HGJQX4YLVRK5TAHGNQ744LAAWVQHTFB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan/Vishal, any comments on this?

Santosh Sivaraj <santosh@fossix.org> writes:

> This cleanup would avoid confusion when ndctl is used for testing
> on non-nfit platforms.
>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  test/blk-exhaust.sh             | 14 +++++++-------
>  test/btt-check.sh               |  8 ++++----
>  test/btt-errors.sh              | 22 +++++++++++-----------
>  test/btt-pad-compat.sh          | 12 ++++++------
>  test/clear.sh                   | 12 ++++++------
>  test/common                     | 10 +++++-----
>  test/create.sh                  | 10 +++++-----
>  test/daxdev-errors.sh           | 14 +++++++-------
>  test/firmware-update.sh         |  8 ++++----
>  test/inject-error.sh            |  8 ++++----
>  test/inject-smart.sh            |  2 +-
>  test/label-compat.sh            | 10 +++++-----
>  test/max_available_extent_ns.sh |  8 ++++----
>  test/monitor.sh                 | 10 +++++-----
>  test/multi-dax.sh               | 12 ++++++------
>  test/pfn-meta-errors.sh         |  8 ++++----
>  test/pmem-errors.sh             |  8 ++++----
>  test/rescan-partitions.sh       |  8 ++++----
>  test/sector-mode.sh             | 14 +++++++-------
>  test/security.sh                | 14 +++++++-------
>  20 files changed, 106 insertions(+), 106 deletions(-)
>
> diff --git a/test/blk-exhaust.sh b/test/blk-exhaust.sh
> index 326ce73..067ed27 100755
> --- a/test/blk-exhaust.sh
> +++ b/test/blk-exhaust.sh
> @@ -23,17 +23,17 @@ trap 'err $LINENO' ERR
>  
>  # setup (reset nfit_test dimms)
>  modprobe nfit_test
> -$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +$NDCTL disable-region -b $TEST_BUS0 all
> +$NDCTL zero-labels -b $TEST_BUS0 all
> +$NDCTL enable-region -b $TEST_BUS0 all
>  
>  # if the kernel accounting is correct we should be able to create two
>  # pmem and two blk namespaces on nfit_test.0
>  rc=1
> -$NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem
> -$NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem
> -$NDCTL create-namespace -b $NFIT_TEST_BUS0 -t blk -m raw
> -$NDCTL create-namespace -b $NFIT_TEST_BUS0 -t blk -m raw
> +$NDCTL create-namespace -b $TEST_BUS0 -t pmem
> +$NDCTL create-namespace -b $TEST_BUS0 -t pmem
> +$NDCTL create-namespace -b $TEST_BUS0 -t blk -m raw
> +$NDCTL create-namespace -b $TEST_BUS0 -t blk -m raw
>  
>  # clearnup and exit
>  _cleanup
> diff --git a/test/btt-check.sh b/test/btt-check.sh
> index ceabee5..c91a5ad 100755
> --- a/test/btt-check.sh
> +++ b/test/btt-check.sh
> @@ -37,7 +37,7 @@ check_min_kver "4.14" || do_skip "may not support badblocks clearing on pmem via
>  
>  create()
>  {
> -	json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem -m sector)
> +	json=$($NDCTL create-namespace -b $TEST_BUS0 -t pmem -m sector)
>  	rc=2
>  	eval "$(echo "$json" | json2var)"
>  	[ -n "$dev" ] || err "$LINENO"
> @@ -50,9 +50,9 @@ create()
>  
>  reset()
>  {
> -	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -	$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -	$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +	$NDCTL disable-region -b $TEST_BUS0 all
> +	$NDCTL zero-labels -b $TEST_BUS0 all
> +	$NDCTL enable-region -b $TEST_BUS0 all
>  }
>  
>  # re-enable the BTT namespace, and do IO to it in an attempt to
> diff --git a/test/btt-errors.sh b/test/btt-errors.sh
> index cb35865..65224b3 100755
> --- a/test/btt-errors.sh
> +++ b/test/btt-errors.sh
> @@ -54,15 +54,15 @@ trap 'err $LINENO cleanup' ERR
>  
>  # setup (reset nfit_test dimms)
>  modprobe nfit_test
> -$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +$NDCTL disable-region -b $TEST_BUS0 all
> +$NDCTL zero-labels -b $TEST_BUS0 all
> +$NDCTL enable-region -b $TEST_BUS0 all
>  
>  rc=1
>  
>  # create a btt namespace and clear errors (if any)
>  dev="x"
> -json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem -m sector)
> +json=$($NDCTL create-namespace -b $TEST_BUS0 -t pmem -m sector)
>  eval "$(echo "$json" | json2var)"
>  [ $dev = "x" ] && echo "fail: $LINENO" && exit 1
>  
> @@ -135,11 +135,11 @@ dd if=$MNT/$FILE of=/dev/null iflag=direct bs=4096 count=1
>  
>  # reset everything to get a clean log
>  if grep -q "$MNT" /proc/mounts; then umount $MNT; fi
> -$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +$NDCTL disable-region -b $TEST_BUS0 all
> +$NDCTL zero-labels -b $TEST_BUS0 all
> +$NDCTL enable-region -b $TEST_BUS0 all
>  dev="x"
> -json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem -m sector)
> +json=$($NDCTL create-namespace -b $TEST_BUS0 -t pmem -m sector)
>  eval "$(echo "$json" | json2var)"
>  [ $dev = "x" ] && echo "fail: $LINENO" && exit 1
>  
> @@ -157,8 +157,8 @@ force_raw 0
>  dd if=/dev/$blockdev of=/dev/null iflag=direct bs=4096 count=1 && err $LINENO || true
>  
>  # done, exit
> -$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +$NDCTL disable-region -b $TEST_BUS0 all
> +$NDCTL zero-labels -b $TEST_BUS0 all
> +$NDCTL enable-region -b $TEST_BUS0 all
>  _cleanup
>  exit 0
> diff --git a/test/btt-pad-compat.sh b/test/btt-pad-compat.sh
> index 2c1f271..a5fc796 100755
> --- a/test/btt-pad-compat.sh
> +++ b/test/btt-pad-compat.sh
> @@ -31,7 +31,7 @@ trap 'err $LINENO' ERR
>  
>  create()
>  {
> -	json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem -m sector)
> +	json=$($NDCTL create-namespace -b $TEST_BUS0 -t pmem -m sector)
>  	rc=2
>  	eval "$(echo "$json" | json2var)"
>  	[ -n "$dev" ] || err "$LINENO"
> @@ -47,9 +47,9 @@ create()
>  
>  reset()
>  {
> -	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -	$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -	$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +	$NDCTL disable-region -b $TEST_BUS0 all
> +	$NDCTL zero-labels -b $TEST_BUS0 all
> +	$NDCTL enable-region -b $TEST_BUS0 all
>  }
>  
>  verify_idx()
> @@ -120,7 +120,7 @@ create_oldfmt_ns()
>  	# that supports a raw namespace with a 4K sector size, prior to
>  	# v4.13 raw namespaces are limited to 512-byte sector size.
>  	rc=77
> -	json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -s 64M -t pmem -m raw -l 4096 -u 00000000-0000-0000-0000-000000000000)
> +	json=$($NDCTL create-namespace -b $TEST_BUS0 -s 64M -t pmem -m raw -l 4096 -u 00000000-0000-0000-0000-000000000000)
>  	rc=2
>  	eval "$(echo "$json" | json2var)"
>  	[ -n "$dev" ] || err "$LINENO"
> @@ -128,7 +128,7 @@ create_oldfmt_ns()
>  	[ $size -gt 0 ] || err "$LINENO"
>  
>  	# reconfig it to sector mode
> -	json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -e $dev -m sector --force)
> +	json=$($NDCTL create-namespace -b $TEST_BUS0 -e $dev -m sector --force)
>  	eval "$(echo "$json" | json2var)"
>  	[ -n "$dev" ] || err "$LINENO"
>  	[ -n "$size" ] || err "$LINENO"
> diff --git a/test/clear.sh b/test/clear.sh
> index 17d5bed..f0b4a9b 100755
> --- a/test/clear.sh
> +++ b/test/clear.sh
> @@ -23,15 +23,15 @@ trap 'err $LINENO' ERR
>  
>  # setup (reset nfit_test dimms)
>  modprobe nfit_test
> -$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +$NDCTL disable-region -b $TEST_BUS0 all
> +$NDCTL zero-labels -b $TEST_BUS0 all
> +$NDCTL enable-region -b $TEST_BUS0 all
>  
>  rc=1
>  
>  # create pmem
>  dev="x"
> -json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem -m raw)
> +json=$($NDCTL create-namespace -b $TEST_BUS0 -t pmem -m raw)
>  eval $(echo $json | json2var)
>  [ $dev = "x" ] && echo "fail: $LINENO" && exit 1
>  [ $mode != "raw" ] && echo "fail: $LINENO" && exit 1
> @@ -73,8 +73,8 @@ fi
>  
>  if check_min_kver "4.9"; then
>  	# check for re-appearance of stale badblocks from poison_list
> -	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -	$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +	$NDCTL disable-region -b $TEST_BUS0 all
> +	$NDCTL enable-region -b $TEST_BUS0 all
>  
>  	# since we have cleared the errors, a disable/reenable shouldn't bring them back
>  	if read sector len < /sys/block/$blockdev/badblocks; then
> diff --git a/test/common b/test/common
> index 1814a0c..54085ae 100644
> --- a/test/common
> +++ b/test/common
> @@ -27,10 +27,10 @@ else
>  fi
>  
>  
> -# NFIT_TEST_BUS[01]
> +# TEST_BUS[01]
>  #
> -NFIT_TEST_BUS0="nfit_test.0"
> -NFIT_TEST_BUS1="nfit_test.1"
> +TEST_BUS0="nfit_test.0"
> +TEST_BUS1="nfit_test.1"
>  ACPI_BUS="ACPI.NFIT"
>  E820_BUS="e820"
>  
> @@ -82,8 +82,8 @@ check_prereq()
>  #
>  _cleanup()
>  {
> -	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -	$NDCTL disable-region -b $NFIT_TEST_BUS1 all
> +	$NDCTL disable-region -b $TEST_BUS0 all
> +	$NDCTL disable-region -b $TEST_BUS1 all
>  	modprobe -r nfit_test
>  }
>  
> diff --git a/test/create.sh b/test/create.sh
> index 8d78797..1398c79 100755
> --- a/test/create.sh
> +++ b/test/create.sh
> @@ -24,15 +24,15 @@ trap 'err $LINENO' ERR
>  
>  # setup (reset nfit_test dimms)
>  modprobe nfit_test
> -$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +$NDCTL disable-region -b $TEST_BUS0 all
> +$NDCTL zero-labels -b $TEST_BUS0 all
> +$NDCTL enable-region -b $TEST_BUS0 all
>  
>  rc=1
>  
>  # create pmem
>  dev="x"
> -json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem -m raw)
> +json=$($NDCTL create-namespace -b $TEST_BUS0 -t pmem -m raw)
>  eval $(echo $json | json2var )
>  [ $dev = "x" ] && echo "fail: $LINENO" && exit 1
>  [ $mode != "raw" ] && echo "fail: $LINENO" &&  exit 1
> @@ -53,7 +53,7 @@ $NDCTL destroy-namespace -f $dev
>  
>  # create blk
>  dev="x"
> -json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t blk -m raw -v)
> +json=$($NDCTL create-namespace -b $TEST_BUS0 -t blk -m raw -v)
>  eval $(echo $json | json2var)
>  [ $dev = "x" ] && echo "fail: $LINENO" && exit 1
>  [ $mode != "raw" ] && echo "fail: $LINENO" &&  exit 1
> diff --git a/test/daxdev-errors.sh b/test/daxdev-errors.sh
> index c5adb72..c877874 100755
> --- a/test/daxdev-errors.sh
> +++ b/test/daxdev-errors.sh
> @@ -23,16 +23,16 @@ trap 'err $LINENO' ERR
>  
>  # setup (reset nfit_test dimms)
>  modprobe nfit_test
> -$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +$NDCTL disable-region -b $TEST_BUS0 all
> +$NDCTL zero-labels -b $TEST_BUS0 all
> +$NDCTL enable-region -b $TEST_BUS0 all
>  
>  rc=1
>  
>  query=". | sort_by(.available_size) | reverse | .[0].dev"
> -region=$($NDCTL list -b $NFIT_TEST_BUS0 -t pmem -Ri | jq -r "$query")
> +region=$($NDCTL list -b $TEST_BUS0 -t pmem -Ri | jq -r "$query")
>  
> -json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -r $region -t pmem -m devdax -a 4096)
> +json=$($NDCTL create-namespace -b $TEST_BUS0 -r $region -t pmem -m devdax -a 4096)
>  chardev=$(echo $json | jq ". | select(.mode == \"devdax\") | .daxregion.devices[0].chardev")
>  
>  #{
> @@ -53,11 +53,11 @@ chardev=$(echo $json | jq ". | select(.mode == \"devdax\") | .daxregion.devices[
>  #  }
>  #}
>  
> -json1=$($NDCTL list -b $NFIT_TEST_BUS0 --mode=devdax --namespaces)
> +json1=$($NDCTL list -b $TEST_BUS0 --mode=devdax --namespaces)
>  eval $(echo $json1 | json2var)
>  nsdev=$dev
>  
> -json1=$($NDCTL list -b $NFIT_TEST_BUS0)
> +json1=$($NDCTL list -b $TEST_BUS0)
>  eval $(echo $json1 | json2var)
>  busdev=$dev
>  
> diff --git a/test/firmware-update.sh b/test/firmware-update.sh
> index 7852e58..dbd5c7f 100755
> --- a/test/firmware-update.sh
> +++ b/test/firmware-update.sh
> @@ -12,9 +12,9 @@ trap 'err $LINENO' ERR
>  
>  reset()
>  {
> -	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -	$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -	$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +	$NDCTL disable-region -b $TEST_BUS0 all
> +	$NDCTL zero-labels -b $TEST_BUS0 all
> +	$NDCTL enable-region -b $TEST_BUS0 all
>  	if [ -f $image ]; then
>  		rm -f $image
>  	fi
> @@ -22,7 +22,7 @@ reset()
>  
>  detect()
>  {
> -	dev=$($NDCTL list -b $NFIT_TEST_BUS0 -D | jq .[0].dev | tr -d '"')
> +	dev=$($NDCTL list -b $TEST_BUS0 -D | jq .[0].dev | tr -d '"')
>  	[ -n "$dev" ] || err "$LINENO"
>  }
>  
> diff --git a/test/inject-error.sh b/test/inject-error.sh
> index 49e68b3..3e33a1b 100755
> --- a/test/inject-error.sh
> +++ b/test/inject-error.sh
> @@ -35,7 +35,7 @@ check_min_kver "4.15" || do_skip "kernel $KVER may not support error injection"
>  
>  create()
>  {
> -	json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem --align=4k)
> +	json=$($NDCTL create-namespace -b $TEST_BUS0 -t pmem --align=4k)
>  	rc=2
>  	eval "$(echo "$json" | json2var)"
>  	[ -n "$dev" ] || err "$LINENO"
> @@ -46,9 +46,9 @@ create()
>  
>  reset()
>  {
> -	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -	$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -	$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +	$NDCTL disable-region -b $TEST_BUS0 all
> +	$NDCTL zero-labels -b $TEST_BUS0 all
> +	$NDCTL enable-region -b $TEST_BUS0 all
>  }
>  
>  check_status()
> diff --git a/test/inject-smart.sh b/test/inject-smart.sh
> index 18655ba..fa18a58 100755
> --- a/test/inject-smart.sh
> +++ b/test/inject-smart.sh
> @@ -4,7 +4,7 @@
>  
>  rc=77
>  . ./common
> -bus="$NFIT_TEST_BUS0"
> +bus="$TEST_BUS0"
>  inj_val="42"
>  
>  trap 'err $LINENO' ERR
> diff --git a/test/label-compat.sh b/test/label-compat.sh
> index dc6226d..a31bf4a 100755
> --- a/test/label-compat.sh
> +++ b/test/label-compat.sh
> @@ -23,12 +23,12 @@ trap 'err $LINENO' ERR
>  
>  # setup (reset nfit_test dimms)
>  modprobe nfit_test
> -$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> +$NDCTL disable-region -b $TEST_BUS0 all
> +$NDCTL zero-labels -b $TEST_BUS0 all
>  
> -# grab the largest pmem region on -b $NFIT_TEST_BUS0
> +# grab the largest pmem region on -b $TEST_BUS0
>  query=". | sort_by(.available_size) | reverse | .[0].dev"
> -region=$($NDCTL list -b $NFIT_TEST_BUS0 -t pmem -Ri | jq -r "$query")
> +region=$($NDCTL list -b $TEST_BUS0 -t pmem -Ri | jq -r "$query")
>  
>  # we assume that $region is comprised of 4 dimms
>  query=". | .regions[0].mappings | sort_by(.dimm) | .[].dimm"
> @@ -40,7 +40,7 @@ do
>  	i=$((i+1))
>  done
>  
> -$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +$NDCTL enable-region -b $TEST_BUS0 all
>  
>  len=$($NDCTL list -r $region -N | jq -r "length")
>  
> diff --git a/test/max_available_extent_ns.sh b/test/max_available_extent_ns.sh
> index 1c7e7bf..5701195 100755
> --- a/test/max_available_extent_ns.sh
> +++ b/test/max_available_extent_ns.sh
> @@ -13,14 +13,14 @@ check_min_kver "4.19" || do_skip "kernel $KVER may not support max_available_siz
>  
>  init()
>  {
> -	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -	$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -	$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +	$NDCTL disable-region -b $TEST_BUS0 all
> +	$NDCTL zero-labels -b $TEST_BUS0 all
> +	$NDCTL enable-region -b $TEST_BUS0 all
>  }
>  
>  do_test()
>  {
> -	region=$($NDCTL list -b $NFIT_TEST_BUS0 -R -t pmem | jq -r 'sort_by(-.size) | .[].dev' | head -1)
> +	region=$($NDCTL list -b $TEST_BUS0 -R -t pmem | jq -r 'sort_by(-.size) | .[].dev' | head -1)
>  
>  	available_sz=$($NDCTL list -r $region | jq -r .[].available_size)
>  	size=$(( available_sz/4 ))
> diff --git a/test/monitor.sh b/test/monitor.sh
> index 29d4ea1..c9f7224 100755
> --- a/test/monitor.sh
> +++ b/test/monitor.sh
> @@ -20,9 +20,9 @@ check_min_kver "4.15" || do_skip "kernel $KVER may not support monitor service"
>  
>  init()
>  {
> -	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -	$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -	$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +	$NDCTL disable-region -b $TEST_BUS0 all
> +	$NDCTL zero-labels -b $TEST_BUS0 all
> +	$NDCTL enable-region -b $TEST_BUS0 all
>  }
>  
>  start_monitor()
> @@ -36,10 +36,10 @@ start_monitor()
>  
>  set_smart_supported_bus()
>  {
> -	smart_supported_bus=$NFIT_TEST_BUS0
> +	smart_supported_bus=$TEST_BUS0
>  	monitor_dimms=$(./list-smart-dimm -b $smart_supported_bus | jq -r .[0].dev)
>  	if [ -z $monitor_dimms ]; then
> -		smart_supported_bus=$NFIT_TEST_BUS1
> +		smart_supported_bus=$TEST_BUS1
>  	fi
>  }
>  
> diff --git a/test/multi-dax.sh b/test/multi-dax.sh
> index 0829bf2..1dca352 100755
> --- a/test/multi-dax.sh
> +++ b/test/multi-dax.sh
> @@ -23,17 +23,17 @@ trap 'err $LINENO' ERR
>  
>  # setup (reset nfit_test dimms)
>  modprobe nfit_test
> -$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +$NDCTL disable-region -b $TEST_BUS0 all
> +$NDCTL zero-labels -b $TEST_BUS0 all
> +$NDCTL enable-region -b $TEST_BUS0 all
>  rc=1
>  
>  query=". | sort_by(.available_size) | reverse | .[0].dev"
> -region=$($NDCTL list -b $NFIT_TEST_BUS0 -t pmem -Ri | jq -r "$query")
> +region=$($NDCTL list -b $TEST_BUS0 -t pmem -Ri | jq -r "$query")
>  
> -json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -r $region -t pmem -m devdax -a 4096 -s 16M)
> +json=$($NDCTL create-namespace -b $TEST_BUS0 -r $region -t pmem -m devdax -a 4096 -s 16M)
>  chardev1=$(echo $json | jq ". | select(.mode == \"devdax\") | .daxregion.devices[0].chardev")
> -json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -r $region -t pmem -m devdax -a 4096 -s 16M)
> +json=$($NDCTL create-namespace -b $TEST_BUS0 -r $region -t pmem -m devdax -a 4096 -s 16M)
>  chardev2=$(echo $json | jq ". | select(.mode == \"devdax\") | .daxregion.devices[0].chardev")
>  
>  _cleanup
> diff --git a/test/pfn-meta-errors.sh b/test/pfn-meta-errors.sh
> index 2b57f19..f930325 100755
> --- a/test/pfn-meta-errors.sh
> +++ b/test/pfn-meta-errors.sh
> @@ -30,15 +30,15 @@ trap 'err $LINENO' ERR
>  
>  # setup (reset nfit_test dimms)
>  modprobe nfit_test
> -$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +$NDCTL disable-region -b $TEST_BUS0 all
> +$NDCTL zero-labels -b $TEST_BUS0 all
> +$NDCTL enable-region -b $TEST_BUS0 all
>  
>  rc=1
>  
>  # create a fsdax namespace and clear errors (if any)
>  dev="x"
> -json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem -m fsdax)
> +json=$($NDCTL create-namespace -b $TEST_BUS0 -t pmem -m fsdax)
>  eval "$(echo "$json" | json2var)"
>  [ $dev = "x" ] && echo "fail: $LINENO" && exit 1
>  
> diff --git a/test/pmem-errors.sh b/test/pmem-errors.sh
> index 9553a3f..8ce57c8 100755
> --- a/test/pmem-errors.sh
> +++ b/test/pmem-errors.sh
> @@ -28,15 +28,15 @@ trap 'err $LINENO cleanup' ERR
>  
>  # setup (reset nfit_test dimms)
>  modprobe nfit_test
> -$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +$NDCTL disable-region -b $TEST_BUS0 all
> +$NDCTL zero-labels -b $TEST_BUS0 all
> +$NDCTL enable-region -b $TEST_BUS0 all
>  
>  rc=1
>  
>  # create pmem
>  dev="x"
> -json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem -m raw)
> +json=$($NDCTL create-namespace -b $TEST_BUS0 -t pmem -m raw)
>  eval $(echo $json | json2var)
>  [ $dev = "x" ] && echo "fail: $LINENO" && false
>  [ $mode != "raw" ] && echo "fail: $LINENO" && false
> diff --git a/test/rescan-partitions.sh b/test/rescan-partitions.sh
> index 9c7b7a0..5e01665 100755
> --- a/test/rescan-partitions.sh
> +++ b/test/rescan-partitions.sh
> @@ -27,9 +27,9 @@ check_prereq "blockdev"
>  
>  reset()
>  {
> -	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -	$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -	$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +	$NDCTL disable-region -b $TEST_BUS0 all
> +	$NDCTL zero-labels -b $TEST_BUS0 all
> +	$NDCTL enable-region -b $TEST_BUS0 all
>  }
>  
>  test_mode()
> @@ -37,7 +37,7 @@ test_mode()
>  	local mode="$1"
>  
>  	# create namespace
> -	json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem -m "$mode")
> +	json=$($NDCTL create-namespace -b $TEST_BUS0 -t pmem -m "$mode")
>  	rc=2
>  	eval "$(echo "$json" | json2var)"
>  	[ -n "$dev" ] || err "$LINENO"
> diff --git a/test/sector-mode.sh b/test/sector-mode.sh
> index 4b964c5..7f60452 100755
> --- a/test/sector-mode.sh
> +++ b/test/sector-mode.sh
> @@ -20,17 +20,17 @@ trap 'err $LINENO' ERR
>  
>  # setup (reset nfit_test dimms)
>  modprobe nfit_test
> -$NDCTL disable-region -b $NFIT_TEST_BUS0 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
> -$NDCTL enable-region -b $NFIT_TEST_BUS0 all
> +$NDCTL disable-region -b $TEST_BUS0 all
> +$NDCTL zero-labels -b $TEST_BUS0 all
> +$NDCTL enable-region -b $TEST_BUS0 all
>  
> -$NDCTL disable-region -b $NFIT_TEST_BUS1 all
> -$NDCTL zero-labels -b $NFIT_TEST_BUS1 all
> -$NDCTL enable-region -b $NFIT_TEST_BUS1 all
> +$NDCTL disable-region -b $TEST_BUS1 all
> +$NDCTL zero-labels -b $TEST_BUS1 all
> +$NDCTL enable-region -b $TEST_BUS1 all
>  
>  rc=1
>  query=". | sort_by(.size) | reverse | .[0].dev"
> -NAMESPACE=$($NDCTL list -b $NFIT_TEST_BUS1 -N | jq -r "$query")
> +NAMESPACE=$($NDCTL list -b $TEST_BUS1 -N | jq -r "$query")
>  REGION=$($NDCTL list -R --namespace=$NAMESPACE | jq -r "(.[]) | .dev")
>  echo 0 > /sys/bus/nd/devices/$REGION/read_only
>  $NDCTL create-namespace --no-autolabel -e $NAMESPACE -m sector -f -l 4K
> diff --git a/test/security.sh b/test/security.sh
> index c86d2c6..80d64df 100755
> --- a/test/security.sh
> +++ b/test/security.sh
> @@ -17,14 +17,14 @@ trap 'err $LINENO' ERR
>  
>  setup()
>  {
> -	$NDCTL disable-region -b "$NFIT_TEST_BUS0" all
> +	$NDCTL disable-region -b "$TEST_BUS0" all
>  }
>  
>  detect()
>  {
> -	dev="$($NDCTL list -b "$NFIT_TEST_BUS0" -D | jq -r .[0].dev)"
> +	dev="$($NDCTL list -b "$TEST_BUS0" -D | jq -r .[0].dev)"
>  	[ -n "$dev" ] || err "$LINENO"
> -	id="$($NDCTL list -b "$NFIT_TEST_BUS0" -D | jq -r .[0].id)"
> +	id="$($NDCTL list -b "$TEST_BUS0" -D | jq -r .[0].id)"
>  	[ -n "$id" ] || err "$LINENO"
>  }
>  
> @@ -83,9 +83,9 @@ lock_dimm()
>  	# inline. Once a subsequent user arrives we can refactor this to a
>  	# helper in test/common:
>  	#   get_test_dimm_path "nfit_test.0" "nmem3"
> -	handle="$($NDCTL list -b "$NFIT_TEST_BUS0"  -d "$dev" -i | jq -r .[].dimms[0].handle)"
> +	handle="$($NDCTL list -b "$TEST_BUS0"  -d "$dev" -i | jq -r .[].dimms[0].handle)"
>  	test_dimm_path=""
> -	for test_dimm in /sys/devices/platform/"$NFIT_TEST_BUS0"/nfit_test_dimm/test_dimm*; do
> +	for test_dimm in /sys/devices/platform/"$TEST_BUS0"/nfit_test_dimm/test_dimm*; do
>  		td_handle_file="$test_dimm/handle"
>  		test -e "$td_handle_file" || continue
>  		td_handle="$(cat "$td_handle_file")"
> @@ -107,7 +107,7 @@ lock_dimm()
>  
>  get_security_state()
>  {
> -	$NDCTL list -i -b "$NFIT_TEST_BUS0" -d "$dev" | jq -r .[].dimms[0].security
> +	$NDCTL list -i -b "$TEST_BUS0" -d "$dev" | jq -r .[].dimms[0].security
>  }
>  
>  setup_passphrase()
> @@ -184,7 +184,7 @@ test_4_security_unlock()
>  		echo "Incorrect security state: $sstate expected: unlocked"
>  		err "$LINENO"
>  	fi
> -	$NDCTL disable-region -b "$NFIT_TEST_BUS0" all
> +	$NDCTL disable-region -b "$TEST_BUS0" all
>  	remove_passphrase
>  }
>  
> -- 
> 2.21.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
