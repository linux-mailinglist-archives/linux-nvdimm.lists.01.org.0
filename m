Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F14441A3D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Jun 2019 04:07:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F28EC21962301;
	Tue, 11 Jun 2019 19:07:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=kirill@shutemov.name; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 30EC621962301
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 19:07:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m10so23092588edv.6
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 19:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=e3TEzE60VRj/MS8YEEehOOQckYotYtM00jSjKCi8/jI=;
 b=MTtnxOj8b/+TTYuM6NNkobIsRNOElKsc/8BqXi3Y/+dNGP7+MZ2IGVtBb9IvQn+OsO
 vW74urYy7EzW8nl+nFudq/JabGlvyX3vo/5Hnrim+qNbyvWWoh95wiXSZNopPL+oXF/O
 eD2Pnlv4mFpK9NfsXHt421c7OE1+1LjF2t546fw5c+ALo6qKpb5Up3nS2VgDyXsEYmXu
 0EFS1eXIH10mQztjtBB9u+208ddm8dhgPx+iDuc40U2BU6O0uLBWML0c78uHFi1gvuAk
 cpkYbNvZV5mNIS/64Z1tTp9WdsscxLL6ysWN85wbls6CM1baoMoKiseSgh4yK5TDDiHE
 ByZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=e3TEzE60VRj/MS8YEEehOOQckYotYtM00jSjKCi8/jI=;
 b=p2l6Dg9EuTqmi/eI0Mgw/ResqGEez0phTvxQ1Hu8TYVZzyq609xwby3nGKUbhiUOtO
 qZ3jgUE2sgAB+uPr84erbsD9LR4ocK1p3DEWQknHT0pOfAO52BLyEhI94pEo3Q4fotjT
 AsDTQZ98yWKScl763Awns7hgAzaWvnObwhKbdwILWM6MAVvvdKlXALW935eGrRlF+xVZ
 QxAu+B0NgREMVBgieCVR+2nl4e8ZU/Fx/mBt6TXTs3E6k+DaJpuyfc0j7VKITHCOdphl
 HFwGVq3C5Li1ORpZUdAwYjOZiqK1U0U+3I7yVSUABxWkQtjl90GJ6HahWzQllLVFYrcE
 cV6g==
X-Gm-Message-State: APjAAAXIq3BVP3ctLONMfjvaStAOfFUdGbMXYYBuMUuiBFTmoYcNfG5Y
 41GWziBls8woUxY8+Q6KCorFzQ==
X-Google-Smtp-Source: APXvYqz0F/coC3G7qHRNAuBkWxFLoYTo3WBL7aSNleJKw+ls654OvYPBn0myZDv5kyjEpbjibAS9FA==
X-Received: by 2002:a17:906:7d4e:: with SMTP id
 l14mr19826791ejp.188.1560305270074; 
 Tue, 11 Jun 2019 19:07:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id v18sm3176634edq.80.2019.06.11.19.07.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 19:07:49 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
 id ECA1F10081B; Wed, 12 Jun 2019 05:07:49 +0300 (+03)
Date: Wed, 12 Jun 2019 05:07:49 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Larry Bassel <larry.bassel@oracle.com>
Subject: Re: [PATCH, RFC 2/2] Implement sharing/unsharing of PMDs for FS/DAX
Message-ID: <20190612020749.sjpuquzxrprkalfy@box>
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
 <1557417933-15701-3-git-send-email-larry.bassel@oracle.com>
 <20190514130147.2pk2xx32aiomm57b@box>
 <20190524160711.GF19025@ubuette>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190524160711.GF19025@ubuette>
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

On Fri, May 24, 2019 at 09:07:11AM -0700, Larry Bassel wrote:
> Again, I don't think this can happen in DAX. The only sharing allowed
> is for FS/DAX/2MiB pagesize.

Hm. I still don't follow. How do you guarantee that DAX actually allocated
continues space for the file on backing storage and you can map it with
PMD page? I believe you don't have such guarantee.


-- 
 Kirill A. Shutemov
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
