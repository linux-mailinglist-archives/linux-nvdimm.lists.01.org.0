Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13B1C942
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 15:16:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 962EA2125ADF0;
	Tue, 14 May 2019 06:16:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=kirill@shutemov.name; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 579FA2194EB7A
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 06:16:56 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id f37so22795401edb.13
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 06:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MTM1aBzPfSK5tgU1k2RNG5j9nKyYFdiQfhSRyC1AQNs=;
 b=zDzjKRXBJHz2yPiLvfNwWdJqq/vB0SaFrHEGC+4tdjK7qgnCrVKdrQGXbzYdw14oyQ
 2FN8i/6zGtMT7lmFJlnRkAQy9xn0Tp8jrpcCjZpMztqBnpJhbPLgLKtBXA5z8CinroXQ
 oUFY0Wc1G6z6gMD8EtLGHoj+izORshYJT61j0WN+f7ynFTnhvncUf8umGzpqVB3Cm+Uo
 tVXzXMPSSLzGbhwbKsIi1DOaLf+pAZVzIsTMvypZUewODOBy3mGMSnUKEn+UfHghHFyo
 n02Y3xxyaGokkB8Wh+M10bEQkurf0e5pdpzJBL1swKYPqDuk23hNfPs5vXLP7F6ulYgp
 ZoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MTM1aBzPfSK5tgU1k2RNG5j9nKyYFdiQfhSRyC1AQNs=;
 b=D4BAWC2X4PSGj7qpiodEBXOIDcBeAwh6Iy6n+DAs2T6unQixKsn6sZ4B1tCrP1+c0v
 OIOWF6M5XBDwnudZ75YB1cZxEFQpSZ4sdoyIPAGBLHyFJtCRJG/Sn5gTPaXqmS2k3ox7
 stzOBIDlaJZIysq3ZUGOa7vDyCF1DKtXchpA01rhzmkPaEkpmr9JBlB7uQ/LHoPU/M2y
 9y7ETWYH/+4uB+Dn585Yd0r4jODbTwjXBrX6wYlw+mDZFcvjAEwgSQwzz2Cbhv0a7GKJ
 iG87gwQp/ZNcoBGgDLFp8/oPmAPOs+ssdi3ieTx7Cry/0u8dn+K9Tu0mshTzEr4T343p
 a4Sg==
X-Gm-Message-State: APjAAAVveqF6R9eXC/+EukKAwNaw6NugnikblfsErPrS0EIr9yWDbDm9
 E4unCV01dDY46pTxLUJnGWjF8A==
X-Google-Smtp-Source: APXvYqxcAIh9/gohpAQTlGcytkwF0FDILsHXqj2wEvoP1yEMfI5z16TGN2EPlhSbHRGWJA81mLADdw==
X-Received: by 2002:a17:906:74a:: with SMTP id
 z10mr15167062ejb.199.1557839814937; 
 Tue, 14 May 2019 06:16:54 -0700 (PDT)
Received: from box.localdomain
 (mm-137-212-121-178.mgts.dynamic.pppoe.byfly.by. [178.121.212.137])
 by smtp.gmail.com with ESMTPSA id h8sm678784ejf.73.2019.05.14.06.16.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 May 2019 06:16:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
 id F1D16100C33; Tue, 14 May 2019 15:28:20 +0300 (+03)
Date: Tue, 14 May 2019 15:28:20 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Larry Bassel <larry.bassel@oracle.com>
Subject: Re: [PATCH, RFC 0/2] Share PMDs for FS/DAX on x86
Message-ID: <20190514122820.26zddpb27uxgrwzp@box>
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
User-Agent: NeoMutt/20180716
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
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 09, 2019 at 09:05:31AM -0700, Larry Bassel wrote:
> This patchset implements sharing of page table entries pointing
> to 2MiB pages (PMDs) for FS/DAX on x86.

-EPARSE.

How do you share entries? Entries do not take any space, page tables that
cointain these entries do.

Have you checked if the patch makes memory consumption any better. I have
doubts in it.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
