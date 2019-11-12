Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A816F8C35
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 10:50:01 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 48D56100DC405;
	Tue, 12 Nov 2019 01:51:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5BACA100EA61A
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 01:51:44 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 97B26B039;
	Tue, 12 Nov 2019 09:49:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 3F48C1E47E5; Tue, 12 Nov 2019 10:49:54 +0100 (CET)
Date: Tue, 12 Nov 2019 10:49:54 +0100
From: Jan Kara <jack@suse.cz>
To: Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: Re: DAX filesystem support on ARMv8
Message-ID: <20191112094954.GC1241@quack2.suse.cz>
References: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: UTOPOCCHB6LOPES3J6KHEJCLHCNI3FNY
X-Message-ID-Hash: UTOPOCCHB6LOPES3J6KHEJCLHCNI3FNY
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UTOPOCCHB6LOPES3J6KHEJCLHCNI3FNY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi!

On Tue 12-11-19 02:12:09, Bharat Kumar Gogada wrote:
> As per Documentation/filesystems/dax.txt
> 
> The DAX code does not work correctly on architectures which have virtually
> mapped caches such as ARM, MIPS and SPARC.
> 
> Can anyone please shed light on dax filesystem issue w.r.t ARM architecture ? 

I've CCed Dan, he might have idea what that comment means :)

Out of curiosity, why do you care?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
