Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7059D1FA2B9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Jun 2020 23:24:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC926110E5FDE;
	Mon, 15 Jun 2020 14:24:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=srs0=bzm1=74=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A1548100A0836
	for <linux-nvdimm@lists.01.org>; Mon, 15 Jun 2020 14:24:32 -0700 (PDT)
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 0A48220679;
	Mon, 15 Jun 2020 21:24:30 +0000 (UTC)
Date: Mon, 15 Jun 2020 17:24:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v13 2/6] seq_buf: Export seq_buf_printf
Message-ID: <20200615172429.6e66ed0f@oasis.local.home>
In-Reply-To: <20200615125552.GI14668@zn.tnic>
References: <20200615124407.32596-1-vaibhav@linux.ibm.com>
	<20200615124407.32596-3-vaibhav@linux.ibm.com>
	<20200615125552.GI14668@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Message-ID-Hash: IEDJIQDPND57RUMY5JT5VL5EDC4AOJBN
X-Message-ID-Hash: IEDJIQDPND57RUMY5JT5VL5EDC4AOJBN
X-MailFrom: SRS0=bzm1=74=goodmis.org=rostedt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Piotr Maziarz <piotrx.maziarz@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Christoph Hellwig <hch@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IEDJIQDPND57RUMY5JT5VL5EDC4AOJBN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2020 14:55:52 +0200
Borislav Petkov <bp@alien8.de> wrote:

> Can you please resend your patchset once a week like everyone else and
> not flood inboxes with it?

Boris,

Haven't you automated your inbox yet? I have patchwork reading my INBOX
and it's smart enough to understand new series, and the old one simply
disappears as "superseded".

Email is just the wires to our infrastructure. Get with the times man! ;-)

-- Steve
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
