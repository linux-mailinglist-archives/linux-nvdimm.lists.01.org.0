Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F5A0915
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Aug 2019 19:57:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3284F20215F53;
	Wed, 28 Aug 2019 10:59:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D959920215F45
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 10:59:44 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 580EE3082E24;
 Wed, 28 Aug 2019 17:57:44 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CED2E5D9E2;
 Wed, 28 Aug 2019 17:57:43 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 0/3] libnvdimm/security: Enumerate the frozen state and
 other cleanups
References: <156686728950.184120.5188743631586996901.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 28 Aug 2019 13:57:43 -0400
In-Reply-To: <156686728950.184120.5188743631586996901.stgit@dwillia2-desk3.amr.corp.intel.com>
 (Dan Williams's message of "Mon, 26 Aug 2019 17:54:49 -0700")
Message-ID: <x4936hl8960.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 28 Aug 2019 17:57:44 +0000 (UTC)
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
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Dan Williams <dan.j.williams@intel.com> writes:

> Changes since v1 [1]:
> - Cleanup patch1, simplify flags return in the overwrite case and
>   consolidate frozen-state cases (Jeff)
> - Clarify the motivation for patch2 (Jeff)
> - Collect Dave's Reviewed-by

The series tests out fine for me.

Thanks, Dan!

-Jeff


>
> [1]: https://lists.01.org/pipermail/linux-nvdimm/2019-August/023133.html
>
> ---
>
> Jeff reported a scenario where ndctl was failing to unlock DIMMs [2].
> Through the course of debug it was discovered that the security
> interface on the DIMMs was in the 'frozen' state disallowing unlock, or
> any security operation.  Unfortunately the kernel only showed that the
> DIMMs were 'locked', not 'locked' and 'frozen'.
>
> Introduce a new sysfs 'frozen' attribute so that ndctl can reflect the
> "security-operations-allowed" state independently of the lock status.
> Then, followup with cleanups related to replacing a security-state-enum
> with a set of flags.
>  
> [2]: https://lists.01.org/pipermail/linux-nvdimm/2019-August/022856.html
>
> ---
>
> Dan Williams (3):
>       libnvdimm/security: Introduce a 'frozen' attribute
>       libnvdimm/security: Tighten scope of nvdimm->busy vs security operations
>       libnvdimm/security: Consolidate 'security' operations
>
>
>  drivers/acpi/nfit/intel.c        |   59 ++++++-----
>  drivers/nvdimm/bus.c             |    2 
>  drivers/nvdimm/dimm_devs.c       |  134 ++++++--------------------
>  drivers/nvdimm/nd-core.h         |   51 ++++------
>  drivers/nvdimm/security.c        |  199 +++++++++++++++++++++++++-------------
>  include/linux/libnvdimm.h        |    9 +-
>  tools/testing/nvdimm/dimm_devs.c |   19 +---
>  7 files changed, 226 insertions(+), 247 deletions(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
