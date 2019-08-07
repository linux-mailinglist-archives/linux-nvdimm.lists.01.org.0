Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 516168556B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Aug 2019 23:48:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E4C0A2131474C;
	Wed,  7 Aug 2019 14:51:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A36AB21314744
 for <linux-nvdimm@lists.01.org>; Wed,  7 Aug 2019 14:51:13 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 49A1230BA07C;
 Wed,  7 Aug 2019 21:48:42 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7A4D5D9DC;
 Wed,  7 Aug 2019 21:48:41 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch] nfit: report frozen security state
References: <x49k1bw7dqn.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4js-dZWFyRM7=JgC31uJUyxVzuwrderFrWf5p=z82E+WA@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 07 Aug 2019 17:48:41 -0400
In-Reply-To: <CAPcyv4js-dZWFyRM7=JgC31uJUyxVzuwrderFrWf5p=z82E+WA@mail.gmail.com>
 (Dan Williams's message of "Wed, 7 Aug 2019 14:36:50 -0700")
Message-ID: <x49ef1whcjq.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 07 Aug 2019 21:48:42 +0000 (UTC)
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Dan Williams <dan.j.williams@intel.com> writes:

> On Thu, Aug 1, 2019 at 2:55 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> If a dimm is frozen, it is currently reported as being "locked".  While
>> that's not technically wrong, it is misleading as the dimm can't be
>> unlocked.  Fix the confusion.
>
> This looks ok, but now I wonder about the case where the DIMM is
> unlocked, but frozen?

Hah, forgot that was even a possibility.  :)

> I think it makes more sense to show "frozen" when the DIMM is
> frozen-locked, and show "unlocked" when frozen-unlocked. I.e. if the
> DIMM is frozen the user should assume it's disabled for general
> purpose operation, and if it's unlocked the fact that it will fail
> some security operations is a constrained error case. Thoughts?

I think that adds confusion.  I think we should print out both whether
or not it's locked and whether or not it's frozen.  Maybe:

unlocked, not frozen:  "unlocked"
locked, not frozen:    "locked"
unlocked, frozen:      "unlocked (frozen)"
locked, frozen:        "locked (frozen)"

Something like that?  I think nvdimm_security_state should be a bitmask,
not an enum.  That may be a part of the problem.

-Jeff

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
