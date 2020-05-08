Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CEC1CB0AC
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 May 2020 15:43:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 48F371162EB27;
	Fri,  8 May 2020 06:41:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2401:3900:2:1::2; helo=ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3F3671162EB26
	for <linux-nvdimm@lists.01.org>; Fri,  8 May 2020 06:41:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 49JWkk2BXVz9sT2;
	Fri,  8 May 2020 23:43:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
	s=201909; t=1588945424;
	bh=p+YBkyP2GHp01pThlHZu2zNE3/neu24osdVU16EmOus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=myzmSBT/czcoOa5b0uNfJvnSn0EcensBRxDGTXSXsFZHz7Ctw4cmolttivclZzczn
	 TlU4xQX1sFeEGOftI9Vt/Yg7n9poabHDRrJD9dFFlDt9HOZEqTv21AH+l6TCSACJ+G
	 LzS3HI2pTjb4HspWPolQxP9uBnlTFgDZQ6ylB+dBKG4qPpkcOlxszBgodBCGGUmAFz
	 Q93GiXrPMyhMZQGgNOXOYLEcRd+vvVE96ReVfh9QW0MP4ysX2iPOSugJKl/xbhnJGC
	 +t49vCyjdXj2x+CfQrmiPjxrxBDghm8z3dEzePmFlSG9Pl3oO4Ea39uGSlgu+ZudGZ
	 ayiGjaAF21wwA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Borislav Petkov <bp@alien8.de>, Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v7 2/5] seq_buf: Export seq_buf_printf() to external modules
In-Reply-To: <20200508113100.GA19436@zn.tnic>
References: <20200508104922.72565-1-vaibhav@linux.ibm.com> <20200508104922.72565-3-vaibhav@linux.ibm.com> <20200508113100.GA19436@zn.tnic>
Date: Fri, 08 May 2020 23:44:00 +1000
Message-ID: <875zd6czj3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-ID-Hash: IY5BM2JPAOVSZ6ALWCJMJLIHZITUIIEY
X-Message-ID-Hash: IY5BM2JPAOVSZ6ALWCJMJLIHZITUIIEY
X-MailFrom: mpe@ellerman.id.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Piotr Maziarz <piotrx.maziarz@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IY5BM2JPAOVSZ6ALWCJMJLIHZITUIIEY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Borislav Petkov <bp@alien8.de> writes:
> On Fri, May 08, 2020 at 04:19:19PM +0530, Vaibhav Jain wrote:
>> 'seq_buf' provides a very useful abstraction for writing to a string
>> buffer without needing to worry about it over-flowing. However even
>> though the API has been stable for couple of years now its stills not
>> exported to external modules limiting its usage.
>> 
>> Hence this patch proposes update to 'seq_buf.c' to mark
>> seq_buf_printf() which is part of the seq_buf API to be exported to
>> external GPL modules. This symbol will be used in later parts of this
>
> What is "external GPL modules"?

A module that has MODULE_LICENSE("GPL") ?

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
