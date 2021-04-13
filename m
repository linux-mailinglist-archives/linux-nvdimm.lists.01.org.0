Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7945E35E1E3
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Apr 2021 16:53:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 22C9A100EB855;
	Tue, 13 Apr 2021 07:53:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.9.137.197; helo=mail.skyhub.de; envelope-from=bp@alien8.de; receiver=<UNKNOWN> 
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 76364100EB84F
	for <linux-nvdimm@lists.01.org>; Tue, 13 Apr 2021 07:53:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b8400dc5952bb5bba9b51.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8400:dc59:52bb:5bba:9b51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84C811EC0118;
	Tue, 13 Apr 2021 16:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1618325596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=Zng+s8B6UzBFhAFGTLiOGYpjULkd5L9TFnuYZ/fZJMw=;
	b=sfqiW9QpHo+w0Mdf7b+STf9grriXJSRP8r96BYJ9IR7mx6BfYZWWjzZJEsCi3zCnfkyBt4
	KzXh30fBsl8U9/Z59iYeeErqvQkOfW2fuWqUtSfDzg7KtMbyyb+7/X0CLl0fZ2SK/qFAUt
	ZFSanaWN0PkXvf+qbFA2pVZNiV4KdpU=
Date: Tue, 13 Apr 2021 16:53:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kemeng Shi <shikemeng@huawei.com>
Subject: Re: Re: [PATCH] x86: Accelerate copy_page with non-temporal in X86
Message-ID: <20210413145315.GF16519@zn.tnic>
References: <3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com>
 <20210413110137.GD16519@zn.tnic>
 <bfa4fd38-0874-63b3-991a-1102af9f47a6@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bfa4fd38-0874-63b3-991a-1102af9f47a6@huawei.com>
Message-ID-Hash: T53D2VW5ENWA2QYWUVOYY3HFYIYOXYVH
X-Message-ID-Hash: T53D2VW5ENWA2QYWUVOYY3HFYIYOXYVH
X-MailFrom: bp@alien8.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T53D2VW5ENWA2QYWUVOYY3HFYIYOXYVH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 13, 2021 at 08:54:55PM +0800, Kemeng Shi wrote:
> Yes. And NT stores should be better for copy_page especially copying a lot
> of pages as only partial memory of copied page will be access recently.

I thought "should be better" too last time when I measured rep; movs vs
NT stores but actual measurements showed no real difference.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
