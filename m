Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D6C2F0875
	for <lists+linux-nvdimm@lfdr.de>; Sun, 10 Jan 2021 17:51:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 10E12100EC1D3;
	Sun, 10 Jan 2021 08:51:44 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2002:c35c:fd02::1; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN> 
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 82097100ED4A7
	for <linux-nvdimm@lists.01.org>; Sun, 10 Jan 2021 08:51:41 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kydvg-008yvh-No; Sun, 10 Jan 2021 16:51:00 +0000
Date: Sun, 10 Jan 2021 16:51:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [RFC v2] nvfs: a filesystem for persistent memory
Message-ID: <20210110165100.GW3579531@ZenIV.linux.org.uk>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110162008.GV3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210110162008.GV3579531@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Message-ID-Hash: YMYIEJMQF454HFNJVWVPIOXGMO7FUKRR
X-Message-ID-Hash: YMYIEJMQF454HFNJVWVPIOXGMO7FUKRR
X-MailFrom: viro@ftp.linux.org.uk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Wang Jianchao <jianchao.wan9@gmail.com>, "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YMYIEJMQF454HFNJVWVPIOXGMO7FUKRR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Jan 10, 2021 at 04:20:08PM +0000, Al Viro wrote:
> On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
> > Hi
> > 
> > I announce a new version of NVFS - a filesystem for persistent memory.
> > 	http://people.redhat.com/~mpatocka/nvfs/
> Utilities, AFAICS
> 
> > 	git://leontynka.twibright.com/nvfs.git
> Seems to hang on git pull at the moment...  Do you have it anywhere else?

D'oh...  In case it's not obvious from the rest of reply, I have managed to
grab it - and forgot to remove the question before sending the comments.
My apologies for the confusion; I plead the lack of coffee...
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
