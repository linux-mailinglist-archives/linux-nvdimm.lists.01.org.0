Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 020ABE7B56
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Oct 2019 22:28:16 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD822100EA63C;
	Mon, 28 Oct 2019 14:29:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A108D100EA63B
	for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1572298090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiDcdcizwPl9edKDomWVmlob3MM7YOG18It5oS0h5Sw=;
	b=PowXkpUaMAkhR0IJPmQNOUw9BOshQ1bgPdUp43GfXxjE7K3KRpYLVCwgPePLNM8/YykEoP
	GW8Fb2pziq3bt8RrEKhAvDuoyHQupeM98OPQQfEOCu8ZtJZrCUolZGTg/VSImdimGt5+Fa
	kZrH10DEzUYNFDRxHZAxEkSBCFqlf5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-ChpLSxxHPeyXbt5tMtcohw-1; Mon, 28 Oct 2019 17:28:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC7BA5E9;
	Mon, 28 Oct 2019 21:28:07 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6133C1001DE1;
	Mon, 28 Oct 2019 21:28:07 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant variable
References: <20191018202302.8122-1-jmoyer@redhat.com>
	<20191018202302.8122-4-jmoyer@redhat.com>
	<20191018205424.GA12760@iweiny-DESK2.sc.intel.com>
	<x49sgnp7ohp.fsf@segfault.boston.devel.redhat.com>
	<49b7cb5dae88ada6945b15eb1cf2e5e798173861.camel@intel.com>
	<7187044f4f6dca57f43879cd2d493949735f63a2.camel@intel.com>
	<20191025222115.GA6536@iweiny-DESK2.sc.intel.com>
	<x49v9s8veyb.fsf@segfault.boston.devel.redhat.com>
	<20191028211338.GA9826@iweiny-DESK2.sc.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 28 Oct 2019 17:28:06 -0400
In-Reply-To: <20191028211338.GA9826@iweiny-DESK2.sc.intel.com> (Ira Weiny's
	message of "Mon, 28 Oct 2019 14:13:39 -0700")
Message-ID: <x49zhhk36hl.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ChpLSxxHPeyXbt5tMtcohw-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: UEE5KJYGDPLEEM4FQ6UZJIBEWGB66IKK
X-Message-ID-Hash: UEE5KJYGDPLEEM4FQ6UZJIBEWGB66IKK
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UEE5KJYGDPLEEM4FQ6UZJIBEWGB66IKK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira Weiny <ira.weiny@intel.com> writes:

> On Mon, Oct 28, 2019 at 03:37:48PM -0400, Jeff Moyer wrote:
>> Ira Weiny <ira.weiny@intel.com> writes:
>> 
>> >> (Watching the unit test run fall into an infinite loop..) Nope, the
>> >> break is in the switch scope, the while loop needs the 'goto out'.
>> >> 
>> >> Yes this bit definitely needs to be refactored :)
>> >
>> > How about this patch instead?  Untested.
>> 
>> I'm not a fan of the looping with gotos.
>
> Me either... But... the logic here is not the same.
>
>>
>> I think separating out the
>> waiting for busy to its own function would make this more clear.
>> Looking more closely, there are other issues.  The timeout code looks at
>> the seconds, but ignores the fractions, so you could be off by almost an
>> entire second, there.
>
> For this operation that is probably not a big deal.  We should be waiting much
> longer than the operation should take anyway.
>
>>
>> It also doens't retry the sleep if interrupted.
>
> This could be an issue.
>
>> Finally, I find the variables names to be highly confusing.
>> 
>> I've decided not to fix those last two bugs just yet, but here's a patch
>> that shows the dirction I think it should go.  Compile-tested only for
>> now.  Let me know what you think.
>
> I thought about doing something similar but to make the logic the same it
> becomes a bit awkward.

[...]

>> +	wait_for_cmd_completion(cmd, fw, &start);
>
> wait_for_cmd_completion() does not call ndctl_cmd_submit()
>
> Now I find it odd that we need to resubmit the command but I assume the logic
> is correct.  Therefore we need to go back and call ndctl_cmd_submit() again.
>
> Or is this not required?

Ah.  Stupid mistake.  Yes, it definitely looks like the status query
command needs to be resubmitted, and that's the whole point of the
timeout between calls.  You can't ask too often.  ;-)

> anyway that is why I went ahead and used the goto...

I'll take another look.  Thanks for pointing out that obvious thinko.

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
