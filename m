Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF366BD0AD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Sep 2019 19:32:24 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 27375202F73B2;
	Tue, 24 Sep 2019 10:34:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C46EF202E6E08
 for <linux-nvdimm@lists.01.org>; Tue, 24 Sep 2019 10:34:42 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t84so2373671oih.10
 for <linux-nvdimm@lists.01.org>; Tue, 24 Sep 2019 10:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vufHR4gTNWqyAPqOkAFSdaMG9FRPmHMMrJOcHYZrZnQ=;
 b=Nm7UWbP88ZdsRNTHKyz/5IW6/lRTd7wGMUWUxRFB0NN2Nlwz29YClrjuWcASt9RI7b
 W5TS10WfepT9X9E4Nx33P7aaCacWJnBE6/d3XXVUxKLXGZZY+QTp+RVfFFZSEpqouwfa
 oD+yTjHI/eI5iCDRdIuhTe+Cs8aBWta5bf4fwOU7UUQO3f8SLaD/vUOEnwORWFe72F1f
 yGmXKBW5wrQNnn6tqxB93uWgYAi0uaJFKlHm/tcwY2fn8fFEEZ6rEm9TLFwvzL/W2z7c
 abSspao32/yeGBlTck+Y5HlJHU38NqSW/6PfzyVXj/2QNon+k2zuzadCbCT8kPQyiebs
 AUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vufHR4gTNWqyAPqOkAFSdaMG9FRPmHMMrJOcHYZrZnQ=;
 b=fPNpqU5rzi0tGIZSiVYwHCfV/rFtxfNilGLskJWaZGyyuyv4oj5AColiAqNqdEcIaZ
 hKidIMwV6AiWdcTMDYIteJ0Ead5Azngjyd/5jH03SIt2KfMB8+hmZbeahR756q1sbrO7
 5ScC1Z34Lb+eulFCRPl/oh4ygyN8iM8gsh/pTfawqd6j4abUTtB5qPBRBW67ebnSDQna
 w/uX1/Axpzq3i7uZGg4XFP7wAfdmUUCO4ANDfLpAUNEuz+8ENcDX8y1wUso3QqLdpkHg
 GThayD0Vaics7b0bOQBKU/mHjmhIs0FTitteEVo68P5jITkN729YNVmYD1wGeNPQXUz3
 Kddw==
X-Gm-Message-State: APjAAAWymE+Kgwy4FfOqXo+5P4UjX0rOMP0o3sF8vS0Q7WS24qmWBJ0p
 btkghnGjcMMOW/MOF4YsFuaaEsO3V73qkgm5u5wYyHS4
X-Google-Smtp-Source: APXvYqxGZn5csplKhSkggqH2B3a79gmO0I8UtOCpk5iIxx+1/zvqH3OzQp2h54EgO/JbZcmQV8+gYjTIbwm7mg3zVfI=
X-Received: by 2002:aca:eb09:: with SMTP id j9mr1173051oih.105.1569346340355; 
 Tue, 24 Sep 2019 10:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190924042440.27946-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190924042440.27946-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 24 Sep 2019 10:32:09 -0700
Message-ID: <CAPcyv4i8a3jLUgMYp8_G9nRxtBJzrz=e4P6T+q_tJSVkhVmi=Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/book3s64: Export has_transparent_hugepage()
 related functions.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Sep 23, 2019 at 9:25 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> In later patch, we want to use hash_transparent_hugepage() in a kernel module.
> Export two related functions.
>

Looks good, thanks.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
