Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B50926C3
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Aug 2019 16:32:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E0C0E20216B78;
	Mon, 19 Aug 2019 07:33:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 853E920214B3A
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 07:33:50 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4804A300413D;
 Mon, 19 Aug 2019 14:32:23 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C58AB1C930;
 Mon, 19 Aug 2019 14:32:22 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/3] libnvdimm/security: Tighten scope of nvdimm->busy vs
 security operations
References: <156583201347.2815870.4687949334637966672.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156583202386.2815870.16611751329252858110.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49zhk8bzuh.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4iPBO9atdr_LdHNt=tCgjh-j_HyKXaCdUkWxb_J7OCcxg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 19 Aug 2019 10:32:22 -0400
In-Reply-To: <CAPcyv4iPBO9atdr_LdHNt=tCgjh-j_HyKXaCdUkWxb_J7OCcxg@mail.gmail.com>
 (Dan Williams's message of "Fri, 16 Aug 2019 14:02:19 -0700")
Message-ID: <x49d0h1usy1.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 19 Aug 2019 14:32:23 +0000 (UTC)
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Dan Williams <dan.j.williams@intel.com> writes:

> On Fri, Aug 16, 2019 at 1:49 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>> > The blanket blocking of all security operations while the DIMM is in
>> > active use in a region is too restrictive. The only security operations
>> > that need to be aware of the ->busy state are those that mutate the
>> > state of data, i.e. erase and overwrite.
>> >
>> > Refactor the ->busy checks to be applied at the entry common entry point
>> > in __security_store() rather than each of the helper routines.
>>
>> I'm not sure this buys you much.  Did you test this on actual hardware
>> to make sure your assumptions are correct?  I guess the worst case is we
>> get an "invalid security state" error back from the firmware....
>>
>> Still, what's the motivation for this?
>
> The motivation was when I went to test setting the frozen state and
> found that it complained about the DIMM being active. There's nothing
> wrong with freezing security while the DIMM is mapped. ...but then I
> somehow managed to write this generalized commit message that left out
> the explicit failure I was worried about. Yes, moved too fast, but the
> motivation is "allow freeze while active" and centralize the ->busy
> check so it's just one function to review that common constraint.

OK, thanks for the info.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
