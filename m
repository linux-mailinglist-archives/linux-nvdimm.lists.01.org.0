Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B381AF3DC
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:55:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 829D810FC62DF;
	Sat, 18 Apr 2020 11:55:52 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3A36810FC62DD
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Sender:Reply-To:Content-ID:Content-Description;
	bh=Fw5l4YeyjM9q5bGtc9HETB0eI3KSL+di5A5JibSeUVA=; b=ZSd4gPvRX+1EcEyWBtmo2xeq+k
	YGKz4bmzRQ0lBLMGURF5oh6CYWK4W10L7kKdDnAI5hJvRsl3/cWENuwUZYgrll4QOeY8IG2KAIwKm
	DmODoHeVwqhNbpPD2mueD4eauFer8yFIuqk42bawnd9he64bV/jQfHVxkRxNmOAMcICHspMdvF49L
	mwjxdxSsr1vLxgUV9OSBDAPsxY5sxHKI3ovi3k6+D0MPLbEOgd5u2ipYWdww6+1xj13RRsP3BbZTP
	5/uu3l5yRFjedkT+1vldVo7jjG4LvH/c3xDAix8dZm74bZ5+P4Sk4RUlA1MpmcdYVcPWYAQRtLCOh
	CMd3C1UQ==;
Received: from [2601:1c0:6280:3f0::19c2]
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPscv-0000Nr-Nv; Sat, 18 Apr 2020 18:55:41 +0000
Subject: Re: [PATCH 2/9] fs: fix empty-body warning in posix_acl.c
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-3-rdunlap@infradead.org>
 <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <722a746a-1438-60e3-04b2-c13eda2ad168@infradead.org>
Date: Sat, 18 Apr 2020 11:55:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
Content-Language: en-US
Message-ID-Hash: PCDDKTIYZUGIJDANQIGAUVYSZ6AKTWA6
X-Message-ID-Hash: PCDDKTIYZUGIJDANQIGAUVYSZ6AKTWA6
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-scsi <linux-scsi@vger.kernel.org>, target-devel <target-devel@vger.kernel.org>, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PCDDKTIYZUGIJDANQIGAUVYSZ6AKTWA6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 4/18/20 11:53 AM, Linus Torvalds wrote:
> On Sat, Apr 18, 2020 at 11:41 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Fix gcc empty-body warning when -Wextra is used:
> 
> Please don't do this.
> 
> First off, "do_empty()" adds nothing but confusion. Now it
> syntactically looks like it does something, and it's a new pattern to
> everybody. I've never seen it before.
> 
> Secondly, even if we were to do this, then the patch would be wrong:
> 
>>         if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
>> -               /* fall through */ ;
>> +               do_empty(); /* fall through */
> 
> That comment made little sense before, but it makes _no_ sense now.
> 
> What fall-through? I'm guessing it meant to say "nothing", and
> somebody was confused. With "do_empty()", it's even more confusing.
> 
> Thirdly, there's a *reason* why "-Wextra" isn't used.
> 
> The warnings enabled by -Wextra are usually complete garbage, and
> trying to fix them often makes the code worse. Exactly like here.

OK, no problem.  That's why PATCH 0/9 says RFC.

Oops. Crap. It was *supposed* to say RFC. :(

-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
