Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 834868A958
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 23:31:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 72AE921311C06;
	Mon, 12 Aug 2019 14:33:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0423C21309D29
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 14:33:43 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D66E7DD11;
 Mon, 12 Aug 2019 21:31:24 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C454360872;
 Mon, 12 Aug 2019 21:31:23 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] daxctl/test: Skip daxctl-devices.sh on older kernels
References: <156531368648.2136155.13013612862545053331.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49pnlagljr.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4jbLNzF3-v6n5m4gmi-WDK5WWW2K_5We+9CX147v89Bcg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 12 Aug 2019 17:31:23 -0400
In-Reply-To: <CAPcyv4jbLNzF3-v6n5m4gmi-WDK5WWW2K_5We+9CX147v89Bcg@mail.gmail.com>
 (Dan Williams's message of "Mon, 12 Aug 2019 14:28:18 -0700")
Message-ID: <x49blwugjf8.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 12 Aug 2019 21:31:24 +0000 (UTC)
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

> On Mon, Aug 12, 2019 at 1:45 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>> > If the 'kmem' module is missing skip the test to support running the
>> > unit tests on older -stable kernels pre-v5.1.
>> >
>> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>
>> Note that the kernel module could also just not be configured.
>
> Yes, but then the test would still report "SKIP" and the developer
> could take a deeper look if they expected to see all "PASS".

Right, I see this as a good thing.  I meant to point out that your
commit message was a bit misleading.

>> > ---
>> >  test/daxctl-devices.sh |    7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/test/daxctl-devices.sh b/test/daxctl-devices.sh
>> > index 04f53f7b13ab..4102fb6990ae 100755
>> > --- a/test/daxctl-devices.sh
>> > +++ b/test/daxctl-devices.sh
>> > @@ -18,6 +18,13 @@ find_testdev()
>> >  {
>> >       local rc=77
>> >
>> > +     # The kmem driver is needed to change the device mode, only
>> > +     # kernels >= v5.1 might have it available. Skip if not.
>> > +     if ! modinfo kmem; then
>> > +             "Unable to find kmem module"
>>
>> I think you need a printf, there.
>
> Whoops, yes.
>
>> Also, do you want the modinfo output in the test log?
>
> Don't think it matters either way since it all ends up in the log.

It's tough to say whether it adds value, so sure, leave it in.

Cheers,
Jeff
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
