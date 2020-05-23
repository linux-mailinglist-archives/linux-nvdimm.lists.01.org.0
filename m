Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CDF1DF70E
	for <lists+linux-nvdimm@lfdr.de>; Sat, 23 May 2020 14:04:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 526E411E16F33;
	Sat, 23 May 2020 05:00:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA62111E16F32
	for <linux-nvdimm@lists.01.org>; Sat, 23 May 2020 05:00:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 49Thpf3hDvz9sRK;
	Sat, 23 May 2020 22:03:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
	s=201909; t=1590235438;
	bh=O3nhdbyrugCN8LK3q4E5ycpy4wCXqUUTYLiEp+dr1H8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pg+pyAIbGIeLiPaclGpnk/vcjO0iw0QR2sp5m+d5FV425fNtw+B+39p82hDercUEY
	 ZJ+mY0CzW0GI2xtxf/n62eTclRhJo6rzBsHYXI+Di/s4bsBjo2OTQm6pujX8uXGjVF
	 bvvDM0nt+6klYh7YVceWiZEyF9uTvLqKDBnotCsHeAmlFZn4WYDrf+8QEqpv0UusCa
	 JefMOnFs3OAl+D8UVcleYvVdbj675xe3insjgc8V8naXHn3nvAgV4edfa1LyDx7n3/
	 77MBFSFAzN7q19WfHkXJFg7nB5DB3BAqtQwmrfwKbw6/F6PfYwoksBD+EarVTcB6h7
	 pBkxFL7qn7tSw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de, mingo@redhat.com
Subject: Re: [PATCH v4 1/2] x86, powerpc: Rename memcpy_mcsafe() to copy_mc_to_{user, kernel}()
In-Reply-To: <159010126739.975921.6393757191247357952.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159010126119.975921.6614194205409771984.stgit@dwillia2-desk3.amr.corp.intel.com> <159010126739.975921.6393757191247357952.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Sat, 23 May 2020 22:04:13 +1000
Message-ID: <87mu5yg8n6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-ID-Hash: 3GG2YU6D4FUF5WESIJR6NELEY7MAXQY4
X-Message-ID-Hash: 3GG2YU6D4FUF5WESIJR6NELEY7MAXQY4
X-MailFrom: mpe@ellerman.id.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: x86@kernel.org, stable@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Mikulas Patocka <mpatocka@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnaldo Carvalho de Melo <acme@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3GG2YU6D4FUF5WESIJR6NELEY7MAXQY4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

Sorry one minor nit below.

Dan Williams <dan.j.williams@intel.com> writes:
> diff --git a/tools/testing/selftests/powerpc/copyloops/.gitignore b/tools/testing/selftests/powerpc/copyloops/.gitignore
> index ddaf140b8255..1152bcc819fe 100644
> --- a/tools/testing/selftests/powerpc/copyloops/.gitignore
> +++ b/tools/testing/selftests/powerpc/copyloops/.gitignore
> @@ -12,4 +12,4 @@ memcpy_p7_t1
>  copyuser_64_exc_t0
>  copyuser_64_exc_t1
>  copyuser_64_exc_t2
> -memcpy_mcsafe_64
> +copy_mc_to_user

Should be:

+copy_mc_64

Otherwise the powerpc bits look good to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
