Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D030D30C6AD
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 17:58:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C836F100F225E;
	Tue,  2 Feb 2021 08:58:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=rpalethorpe@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C8339100F225D
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 08:58:27 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 3F28FAF1B;
	Tue,  2 Feb 2021 16:58:26 +0000 (UTC)
References: <20200615074723.12163-1-rpalethorpe@suse.com>
 <CAPcyv4jzfnnOTJTK5WKYpt_qOm1UWv-PZ7ZH3GiXf7x_oz6jQw@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] nvdimm: Avoid race between probe and reading device
 attributes
In-reply-to: <CAPcyv4jzfnnOTJTK5WKYpt_qOm1UWv-PZ7ZH3GiXf7x_oz6jQw@mail.gmail.com>
Date: Tue, 02 Feb 2021 16:58:25 +0000
Message-ID: <87im7acspa.fsf@suse.de>
MIME-Version: 1.0
Message-ID-Hash: FTCP46G6277JBA2YXG3FPCCCGTRHNTEV
X-Message-ID-Hash: FTCP46G6277JBA2YXG3FPCCCGTRHNTEV
X-MailFrom: rpalethorpe@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Coly Li <colyli@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: rpalethorpe@suse.de
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FTCP46G6277JBA2YXG3FPCCCGTRHNTEV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Dan,

Dan Williams <dan.j.williams@intel.com> writes:
>
> I see why this works, but I think the bug is in
> available_slots_show(). It is a bug for a sysfs attribute to reference
> driver-data without synchronizing against bind. So it should be
> possible for probe set that pointer whenever it wants. In other words
> this fix (forgive the whitespace damage from pasting).

Ah, that makes sense! I see the new patch and all is good AFAICT.

-- 
Thank you,
Richard.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
