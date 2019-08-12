Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D795B8A04C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 16:03:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C42F212FE8BB;
	Mon, 12 Aug 2019 07:05:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 13766212FD508
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 07:05:50 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 106D730023D8;
 Mon, 12 Aug 2019 14:03:29 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CD5F62670;
 Mon, 12 Aug 2019 14:03:28 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] ndctl/test: Add xfs reflink dependency
References: <156531368129.2136155.4247732841095137080.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 12 Aug 2019 10:03:27 -0400
In-Reply-To: <156531368129.2136155.4247732841095137080.stgit@dwillia2-desk3.amr.corp.intel.com>
 (Dan Williams's message of "Thu, 08 Aug 2019 18:21:21 -0700")
Message-ID: <x494l2mjxao.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 12 Aug 2019 14:03:29 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Dan Williams <dan.j.williams@intel.com> writes:

> Starting with xfsprogs version 5.1.0 it will enable reflink by default.
> Any scripts, like ndctl unit tests, that were doing:
>
>     mkfs.xfs $pmem; mount -o dax $pmem $mnt
>
> ...must now do:
>
>     mkfs.xfs -m reflink=0 $pmem; mount -o dax $pmem $mnt

Agreed.  In the future, the options may not be mutually exclusive, but I
don't see any harm in always testing with reflink=0 for the existing
tests.

Acked-by: Jeff Moyer <jmoyer@redhat.com>

>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  test/dax.sh  |    4 ++--
>  test/mmap.sh |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/test/dax.sh b/test/dax.sh
> index e703e1222dee..3bb44ac0a26c 100755
> --- a/test/dax.sh
> +++ b/test/dax.sh
> @@ -69,7 +69,7 @@ json=$($NDCTL create-namespace -m raw -f -e $dev)
>  eval $(json2var <<< "$json")
>  [ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
>  
> -mkfs.xfs -f /dev/$blockdev
> +mkfs.xfs -f /dev/$blockdev -m reflink=0
>  mount /dev/$blockdev $MNT -o dax
>  fallocate -l 1GiB $MNT/$FILE
>  run_test
> @@ -80,7 +80,7 @@ json=$($NDCTL create-namespace -m fsdax -M dev -f -e $dev)
>  eval $(json2var <<< "$json")
>  [ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
>  
> -mkfs.xfs -f /dev/$blockdev
> +mkfs.xfs -f /dev/$blockdev -m reflink=0
>  mount /dev/$blockdev $MNT -o dax
>  fallocate -l 1GiB $MNT/$FILE
>  run_test
> diff --git a/test/mmap.sh b/test/mmap.sh
> index afe50fd2199b..d072ea289f31 100755
> --- a/test/mmap.sh
> +++ b/test/mmap.sh
> @@ -70,7 +70,7 @@ fallocate -l 1GiB $MNT/$FILE
>  test_mmap
>  umount $MNT
>  
> -mkfs.xfs -f $DEV
> +mkfs.xfs -f $DEV -m reflink=0
>  mount $DEV $MNT -o dax
>  fallocate -l 1GiB $MNT/$FILE
>  test_mmap
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
