Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858762F5035
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 17:44:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 37F11100EB345;
	Wed, 13 Jan 2021 08:44:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 58E03100EB344
	for <linux-nvdimm@lists.01.org>; Wed, 13 Jan 2021 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1610556279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2nZaowcmYpAm6+Q7xTb3SoumDbJkYtkPecNpTcfdqc=;
	b=gvmR8F0EbASo0nL0dV8lZ1GlhFmyJlkBeGGMQffQY7SY/sauHd0Ofyh1Pge1YL3vchdVmY
	fs6YYNA9X5Rxl3krfkKAd9u5R/ITRkqRaExL3QpNQfSTeVXHixtErfW2ZP739RYzZyvBiI
	4VPiU4tJmeBHnXHlINjuGaRhXOOdzYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-n2t6kthuPH2jhsKcw9bewQ-1; Wed, 13 Jan 2021 11:44:35 -0500
X-MC-Unique: n2t6kthuPH2jhsKcw9bewQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0654A806660;
	Wed, 13 Jan 2021 16:44:33 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E0C6062F;
	Wed, 13 Jan 2021 16:44:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 10DGiWGW005756;
	Wed, 13 Jan 2021 11:44:32 -0500
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 10DGiUmf005752;
	Wed, 13 Jan 2021 11:44:31 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Wed, 13 Jan 2021 11:44:30 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Zhongwei Cai <sunrise_l@sjtu.edu.cn>
Subject: Re: Expense of read_iter
In-Reply-To: <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
Message-ID: <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210107151125.GB5270@casper.infradead.org> <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com> <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: DQJDXQAEBFTYRJLSYQMQD3UGXXHXAYC3
X-Message-ID-Hash: DQJDXQAEBFTYRJLSYQMQD3UGXXHXAYC3
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mingkai Dong <mingkaidong@gmail.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Wang Jianchao <jianchao.wan9@gmail.com>, "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DQJDXQAEBFTYRJLSYQMQD3UGXXHXAYC3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 12 Jan 2021, Zhongwei Cai wrote:

> 
> I'm working with Mingkai on optimizations for Ext4-dax.

What specific patch are you working on? Please, post it somewhere.

> We think that optmizing the read-iter method cannot achieve the
> same performance as the read method for Ext4-dax. 
> We tried Mikulas's benchmark on Ext4-dax. The overall time and perf
> results are listed below:
> 
> Overall time of 2^26 4KB read.
> 
> Method       Time
> read         26.782s
> read-iter    36.477s

What happens if you use this trick ( https://lkml.org/lkml/2021/1/11/1612 )
- detect in the "read_iter" method that there is just one segment and 
treat it like a "read" method. I think that it should improve performance 
for your case.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
