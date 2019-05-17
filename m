Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615921CAC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 19:41:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4145D21276745;
	Fri, 17 May 2019 10:41:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B461A21237AA0
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 10:41:54 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a8so11701113edx.3
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3LnlSs+ZonWEC1aY2I81/AkRNe2SHRLNnWdqebK4qHA=;
 b=hlHVnALyh1iW5kvImicnZX0j20EY6TA0LRqPJ8vLPADKskcKjsfLhV69KsfqSVQE9E
 QBXQkGg7bW35hlui7GIZ6qa4ciyKhzp0cJzadhdjdrnsrPYtIf/mVhVEpkmRs/ct47C2
 9cuGbwfxGl3xbhv0OJw2pgz2dsUDbibiz0TWOM6m+PoBJTkg25r5vbHyYydLW5zIJKV6
 OMUPMCZvnVlSLMqKKOJOD6sQjEzKJf6yypVbmHQR8r5po82fFz383NO96k9eCtYcwUoa
 b/aBVCwBZMd2TguWqZHlWKmQcvZJw124ApGfDTvooOCGh6FiS5izNWV5cNL0VIIOjjMZ
 ewHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3LnlSs+ZonWEC1aY2I81/AkRNe2SHRLNnWdqebK4qHA=;
 b=R7SF8O/EoeTaj0ndo4G0KWT0t+/o3FPT9rSnZ2tE5JxYb+pLQF6vHvYs+RX9BACQTQ
 1MT8dipoHkjmB75pzSAFdwK9xZameCTOKrJ0ur7YezH41Xhdmwwr8cTWgSIHDBtutpCq
 w8NvFUMfh8Pm6R4Zl6juqb+utjUn7bf/Cw9uhsf18vgHnk6+h4OS7iN2BbVYxHg6cVKv
 vGEPRGYeVAI/+EpIs2cOY2mLMkwP3DWh9BRA+mz9Polo/7DThvyo6F5GLXGmA30krmOD
 qH7B9ER8/coczWsa4+tAiTzqf0liKsX9/ft+1wiQ8zWCOhzZSQgSjOK7aUVoqokA4N5b
 Lr7A==
X-Gm-Message-State: APjAAAVdcmDb70SaVMNcuPgUJTethym3/MOUywf3hc1MnxJPnVucqz0L
 UjmnZwk0izcUjblNaGNlGMD4j9nytk4ix2Jv2yCaKn6wC/M=
X-Google-Smtp-Source: APXvYqwvW6oBmQkXCqawTFL3ATbzkZ8Sb82kZH7TDewIxNyeVxYD7eSZV/Sp4UDYvREtPu52Ip3Kqw+CkpsjW4166qk=
X-Received: by 2002:a50:ab1d:: with SMTP id s29mr59094106edc.56.1558114913238; 
 Fri, 17 May 2019 10:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190516224053.3655-1-vishal.l.verma@intel.com>
 <CA+CK2bCEUjCNGHcfqh+4gxtf80eUkz_swNny6A2mkJwLi6Yn+Q@mail.gmail.com>
 <ff36c9ecc9073ea39b0a501d8abf5cfc48db388f.camel@intel.com>
In-Reply-To: <ff36c9ecc9073ea39b0a501d8abf5cfc48db388f.camel@intel.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 17 May 2019 13:41:42 -0400
Message-ID: <CA+CK2bCtZGAjQa9OAckgoecz31xN_1iYFkUjzmLhshSa80bSFA@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 00/10] daxctl: add a new reconfigure-device
 command
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
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
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> Hi Pavel,
>
> I've still not been able to hit this in my testing, is it something you
> hit only after applying these patches? i.e. does plain v65 work?

Yes, plain v65 works, but with these patches I see this error.

I use buildroot to build initramfs with ndctl. Here is how ndctl.mk looks like:

NDCTL_VERSION = ed17fd1
NDCTL_SITE = $(call github,pmem,ndctl,$(NDCTL_VERSION))
NDCTL_LICENSE = GNU Lesser General Public License v2.1
NDCTL_LICENSE_FILES = COPYING

#NDCTL_AUTORECv65ONF = YES
define NDCTL_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
NDCTL_PRE_CONFIGURE_HOOKS += NDCTL_RUN_AUTOGEN
NDCTL_LDFLAGS = $(TARGET_LDFLAGS)
NDCTL_CONF_OPTS = \
        --without-bash \
        --without-keyutils \
        --without-systemd

$(eval $(autotools-package))

This version works,  but when I change:
NDCTL_VERSION = 9ee82c8

I get add_dev error.

Pasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
