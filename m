Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A565A0FF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 18:33:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A8163212AB4EE;
	Fri, 28 Jun 2019 09:33:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 166E5212AB4DE
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 09:33:50 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id l15so6552372otn.9
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C5XhcDU6eHDsjHZSBvruupbGEAPLyXEBQaVgsJASp/M=;
 b=D1ToJybdEnzma0OsziYT5+nxDaSkNPJrp7CNsMBtITOLU9+/6mSU8iSJzl0odLczf6
 J+NJ1U3WVt6iz4ZNtK7O4B+I6SwhPHdmd0LCP3FM9Q7M8PpdCLD3yCikHMF8JisbHojD
 8KdWhr837Jg14qpnK2c26np5bgqk4Sdt9wQpeW52XG/+opLeMhyE5Zeknlc5DM7hM1vd
 gJXR5dqR48+7h+PE8PF0EAZtcQGoyieYya5bpdNretH4jGkw3uFBm3qz/4rEkogPFffJ
 I8zmVSNFi8wJTP08HjuI3oB0cMcDmI8+DeCY4U9/lHmynz1ISjtE4qtidP1lMsdP9lD1
 2zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C5XhcDU6eHDsjHZSBvruupbGEAPLyXEBQaVgsJASp/M=;
 b=BIhJqAhtGlDv2/I8uK9B8bAIGvAefKa58ibKS3I4zRsNEp9O+ycotFYDXJCc/mKlj2
 5NO8SkFlzX+wvFfXVL+QwpUYBTmxjDJCvECmssvoPYvAUoFiXsBY3Fjylj9bqdzaZtA6
 IsXhIhebGyRfb34jWEMrxfHj5A0LIyzKyQO0QFaf32hbolBTeHUtY/l7f2Khctq0Xh6l
 k7OtCE5Uqd0i92lvXfDUltD/lsHQND1ubVaqnC0Ko0lgVwjMNUm24MaQ1eQWwsrjpJ+X
 XzfOCSMZK+w7Z+3uxP5ET3hEMMzAKXT0H6Ag3kQfR3evLrs2vt0Atd/oK9/wwpc4/FPJ
 sLLA==
X-Gm-Message-State: APjAAAXXlYl6CEWCGgZqdw4wU+Mluj0isONmWsB8Wn1VOFRwiJKJoHxg
 3jFQNUnbzQwu4J6aMKguHIzNmqnMch2rsdjX5sMe8w==
X-Google-Smtp-Source: APXvYqzzYpdHgz4eglyne1uwTiVU7YP+ALyFG4sJtW5FcR4KUORfrVfDmiYmCAAGckLspi0ARU5vSc0QNvBcZT5BUKc=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr8593114oto.207.1561739630274; 
 Fri, 28 Jun 2019 09:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <bd756f3565213887a1fe82a382f7dfe7f9119f1f.1561724493.git.mchehab+samsung@kernel.org>
In-Reply-To: <bd756f3565213887a1fe82a382f7dfe7f9119f1f.1561724493.git.mchehab+samsung@kernel.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Jun 2019 09:33:39 -0700
Message-ID: <CAPcyv4jGcXEvqYZ5aE1QUCd-zeJ8cO=yGtjcwGbYd59A+6FYxw@mail.gmail.com>
Subject: Re: [PATCH 04/39] docs: nvdimm: add it to the driver-api book
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 28, 2019 at 5:30 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> The descriptions here are from Kernel driver's PoV.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
