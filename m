Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438C2B1089
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 16:00:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B1643202E292F;
	Thu, 12 Sep 2019 07:00:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 43B03202E2917
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 07:00:15 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C1363082D9E;
 Thu, 12 Sep 2019 14:00:12 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9365760872;
 Thu, 12 Sep 2019 14:00:11 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
References: <cover.1568256705.git.joe@perches.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 12 Sep 2019 10:00:10 -0400
In-Reply-To: <cover.1568256705.git.joe@perches.com> (Joe Perches's message of
 "Wed, 11 Sep 2019 19:54:30 -0700")
Message-ID: <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 12 Sep 2019 14:00:12 +0000 (UTC)
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
Cc: linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Joe Perches <joe@perches.com> writes:

> Rather than have a local coding style, use the typical kernel style.

The coding style isn't that different from the core kernel, and it's
still quite readable.  I'd rather avoid the churn and the risk of
introducing regressions.  This will also make backports to stable more
of a pain, so it isn't without cost.  Dan, is this really something you
want to do?

-Jeff

>
> Joe Perches (13):
>   nvdimm: Use more typical whitespace
>   nvdimm: Move logical continuations to previous line
>   nvdimm: Use octal permissions
>   nvdimm: Use a more common kernel spacing style
>   nvdimm: Use "unsigned int" in preference to "unsigned"
>   nvdimm: Add and remove blank lines
>   nvdimm: Use typical kernel brace styles
>   nvdimm: Use typical kernel style indentation
>   nvdimm: btt.h: Neaten #defines to improve readability
>   nvdimm: namespace_devs: Move assignment operators
>   nvdimm: Use more common logic testing styles and bare ; positions
>   nvdimm: namespace_devs: Change progess typo to progress
>   nvdimm: Miscellaneous neatening
>
>  drivers/nvdimm/badrange.c       |  22 +-
>  drivers/nvdimm/blk.c            |  39 ++--
>  drivers/nvdimm/btt.c            | 249 +++++++++++----------
>  drivers/nvdimm/btt.h            |  56 ++---
>  drivers/nvdimm/btt_devs.c       |  68 +++---
>  drivers/nvdimm/bus.c            | 138 ++++++------
>  drivers/nvdimm/claim.c          |  50 ++---
>  drivers/nvdimm/core.c           |  42 ++--
>  drivers/nvdimm/dax_devs.c       |   3 +-
>  drivers/nvdimm/dimm.c           |   3 +-
>  drivers/nvdimm/dimm_devs.c      | 107 ++++-----
>  drivers/nvdimm/e820.c           |   2 +-
>  drivers/nvdimm/label.c          | 213 +++++++++---------
>  drivers/nvdimm/label.h          |   6 +-
>  drivers/nvdimm/namespace_devs.c | 472 +++++++++++++++++++++-------------------
>  drivers/nvdimm/nd-core.h        |  31 +--
>  drivers/nvdimm/nd.h             |  94 ++++----
>  drivers/nvdimm/nd_virtio.c      |  20 +-
>  drivers/nvdimm/of_pmem.c        |   6 +-
>  drivers/nvdimm/pfn_devs.c       | 136 ++++++------
>  drivers/nvdimm/pmem.c           |  57 ++---
>  drivers/nvdimm/pmem.h           |   2 +-
>  drivers/nvdimm/region.c         |  20 +-
>  drivers/nvdimm/region_devs.c    | 160 +++++++-------
>  drivers/nvdimm/security.c       | 138 ++++++------
>  drivers/nvdimm/virtio_pmem.c    |  10 +-
>  26 files changed, 1115 insertions(+), 1029 deletions(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
